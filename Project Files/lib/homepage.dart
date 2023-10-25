import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super (key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
// sign out için kullanılacak kod
void SignUserOut(){
  FirebaseAuth.instance.signOut();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: SignUserOut, icon: Icon(Icons.logout))
        ],
      ),
      backgroundColor: Colors.deepPurpleAccent.shade200,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {

            },
            tooltip: 'Kamera ile Çek',
            child: Icon(Icons.camera_alt, color: Colors.deepPurpleAccent.shade200),
            backgroundColor: Colors.white,
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(animationDuration: Duration(milliseconds: 400), backgroundColor: Colors.deepPurpleAccent.shade200, items: [
        Icon(Icons.favorite, color: Colors.red.shade700),
        Icon(Icons.home),
        Icon(Icons.person)
      ],
      ),
    );
  }
}
