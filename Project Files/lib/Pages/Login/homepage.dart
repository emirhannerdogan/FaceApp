import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// sign out için kullanılacak kod
void SignUserOut() {
  FirebaseAuth.instance.signOut();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          IconButton(onPressed: SignUserOut, icon: Icon(Icons.logout))
        ],
      ),
      backgroundColor: Colors.deepPurpleAccent.shade200,
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 400),
        backgroundColor: Colors.deepPurpleAccent.shade200,
        items: [
          Icon(Icons.favorite, color: Colors.red.shade700),
          const Icon(Icons.home),
          const Icon(Icons.person)
        ],
      ),
    );
  }
}
