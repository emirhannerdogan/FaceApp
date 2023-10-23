import 'package:faceapp/pages/home_page.dart';
import 'package:faceapp/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FaceApp());
}

class FaceApp extends StatelessWidget {
  const FaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
