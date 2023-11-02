import 'package:flutter/material.dart';

class PeoplePage extends StatelessWidget {
  static const backgroundColor = Color.fromRGBO(31, 29, 54, 1);

  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Text(
          "People",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
