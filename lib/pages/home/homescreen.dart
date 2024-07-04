import 'package:flutter/material.dart';
import 'package:mobilapp2/constants.dart';
import 'package:mobilapp2/pages/home/AddCategoryScreen.dart';
import 'package:mobilapp2/pages/home/background1.dart';
import 'package:mobilapp2/pages/home/bookmarkpage.dart';
import 'package:mobilapp2/pages/home/settingspage.dart';
import 'package:mobilapp2/pages/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilapp2/pages/home/components/categoryCards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background1(
      topImage: "assets/images/main_top.png",
      bottomImage: "assets/images/login_bottom.png",
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 50,
          shape: const RoundedRectangleBorder(),
          automaticallyImplyLeading: false,
          actions: const [],
          title: const Text(
            "Engelsiz Adımlar",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500, // Normal kalınlık
              fontSize: 30,
              fontFamily: 'Poppins', // Kullanılan font ailesi
              color: kPrimaryColor,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: kPrimaryColor, // Seçilmemiş öğelerin rengi
          currentIndex: 0,
          onTap: (value) {
            switch (value) {
              case 0:
              // Anasayfa
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
                break;
              default:
                break;
            }
          },
          backgroundColor: const Color.fromRGBO(255, 255, 255, 0.5),
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Yeni yerler keşfet..',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.only(top: 10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 1),
                    Container(
                      height: 60,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AddCategoryCardScreen()),
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 5),
                SizedBox(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryCard(
                        title: "Popüler",
                        press: () {},
                      ),
                      CategoryCard(
                        title: "Cafeler",
                        press: () {},
                      ),
                      CategoryCard(
                        title: "Geçitler",
                        press: () {},
                      ),
                      CategoryCard(
                        title: "Yollar",
                        press: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final List<DocumentSnapshot> documents = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: documents.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot document = documents[index];
                          final String title = document['title'];
                          final String address = document['address'];
                          final String description = document['description'];
                          final String imageUrl = document['image'];
                          final String location = document['location'];

                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Card(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  imageUrl.isNotEmpty
                                      ? Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  )
                                      : Container(
                                    width: double.infinity,
                                    height: 250,
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.image,
                                      size: 100,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: kPrimaryColor,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              location,
                                              style: const TextStyle(color: kPrimaryColor),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          address,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          description,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
