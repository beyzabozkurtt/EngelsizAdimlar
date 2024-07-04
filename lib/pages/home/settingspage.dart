import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilapp2/constants.dart';
import 'package:mobilapp2/pages/home/bookmarkpage.dart';
import 'package:mobilapp2/pages/home/homescreen.dart';
import 'package:mobilapp2/pages/home/background1.dart';
import 'package:mobilapp2/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIcon = 2; // Varsayılan olarak 'Profil' ikonunu seçili olarak ayarla
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  String? _selectedDisability;
  String? _userEmail = "Kullanıcı bilgisi bulunamadı";

  final List<String> _disabilityOptions = [
    'Görme Engelli',
    'İşitme Engelli',
    'Fiziksel Engelli',
    'Dil ve Konuşma Engelli',
    'Zihinsel Engelli',
    'Diğer'
  ];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          _userEmail = userDoc['email'] ?? "Kullanıcı bilgisi bulunamadı";
          _ageController.text = userDoc['age'] ?? '';
          _occupationController.text = userDoc['occupation'] ?? '';
          _selectedDisability = userDoc['disability'] ?? null;
        });
      }
    }
  }

  Future<void> _saveUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': user.email,
        'age': _ageController.text,
        'occupation': _occupationController.text,
        'disability': _selectedDisability,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bilgileriniz başarıyla kaydedildi!')),
      );
    }
  }

  Future<void> _signOut() async {
    final bool? confirmSignOut = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Çıkış Yap'),
          content: Text('Çıkış yapmak istediğinizden emin misiniz?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Colors.white, // Kenar rengini mor olarak ayarlar
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Hayır'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Evet'),
            ),
          ],
        );
      },
    );

    if (confirmSignOut != null && confirmSignOut) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainApp()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Background1(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 400, 0.15),
          elevation: 55,
          toolbarHeight: 55,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
          ),
          title: const Text('Profil'),
          actions: [
            IconButton(
              onPressed: _signOut,
              icon: const Icon(Icons.exit_to_app),
              tooltip: 'Çıkış Yap',
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: kPrimaryColor,
          currentIndex: _selectedIcon,
          onTap: (value) {
            setState(() {
              _selectedIcon = value;
            });
            // Yönlendirme işlemi
            switch (value) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage()),
                );
                break;
              case 2:
              // Zaten 'Profil' sayfasındayız, dolayısıyla bir işlem yapmaya gerek yok
                break;
              default:
                break;
            }
          },
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.5),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Anasayfa",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: "Rota",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profil",
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/profile_image.png'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _userEmail ?? 'Kullanıcı bilgisi bulunamadı',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  const Text(
                    'Yaşınız',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      hintText: 'Yaşınızı girin...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  const Text(
                    'Mesleğiniz',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextField(
                    controller: _occupationController,
                    decoration: InputDecoration(
                      hintText: 'Mesleğinizi girin...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Engel Durumunuzu Seçiniz',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedDisability,
                    items: _disabilityOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDisability = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _saveUserInfo,
                    child: const Text('Bilgileri Kaydet'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
