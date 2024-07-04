import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:mobilapp2/pages/home/homescreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/welcome2.jpg",
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ListView(
                // Use ListView instead of Column
                children: [
                  Text(
                    "Hadi hep beraber",
                    style: TextStyle(
                      wordSpacing: 2.5,
                      color: Colors.white,
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    "Engelsiz yerleri gezelim",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      wordSpacing: 4.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 70,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.black54, width: 4),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
