import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const backgroundColor = Color.fromRGBO(31, 29, 54, 1);

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Text(
          "Profile Page",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
