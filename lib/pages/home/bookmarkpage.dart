import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _pGooglePlex= LatLng(39.9334, 32.8597);

  late GoogleMapController mapController;
  Set<Marker> markers = {};
  Polyline? polyline;
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('En İyi Rota'),
        backgroundColor: Colors.white,
        elevation: 0, // AppBar'ın gölgesini kaldırır
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _pGooglePlex,
              zoom: 13,
            ),
            markers: markers,
            polylines: polyline != null ? Set<Polyline>.of([polyline!]) : Set<Polyline>(),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    mapController.animateCamera(CameraUpdate.zoomIn());
                  },
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: () {
                    mapController.animateCamera(CameraUpdate.zoomOut());
                  },
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Senin için en iyi rotayı bulalım!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: startController,
                      decoration: InputDecoration(
                        hintText: 'Başlangıç Adresi',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: endController,
                      decoration: InputDecoration(
                        hintText: 'Bitiş Adresi',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _getDirections(startController.text, endController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text('Rota Oluştur'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addMarker(LatLng position, String id) {
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(id),
          position: position,
          infoWindow: InfoWindow(
            title: id,
          ),
        ),
      );
    });
  }

  Future<void> _getDirections(String startAddress, String endAddress) async {
    final String apiUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$startAddress&destination=$endAddress&key=AIzaSyAj_HE7zsuTIlTYD3arpKbTwPJ24eOhxLM";

    final http.Response response = await http.get(Uri.parse(apiUrl));
    final data = jsonDecode(response.body);
    final routes = data["routes"];
    if (routes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Rota bulunamadı')));
      return;
    }
    final points = routes[0]["overview_polyline"]["points"];

    List<LatLng> decodedPoints = _decodePoly(points);
    setState(() {
      polyline = Polyline(
        polylineId: PolylineId("route"),
        points: decodedPoints,
        color: Colors.blue,
        width: 3,
      );
    });
  }

  List<LatLng> _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = <double>[];
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;
      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negative then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    List<LatLng> points = [];
    for (var i = 0; i < lList.length; i += 2) {
      points.add(LatLng(lList[i], lList[i + 1]));
    }
    return points;
  }
}
