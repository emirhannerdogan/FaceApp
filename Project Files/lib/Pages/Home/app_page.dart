import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:faceapp/Pages/Home/home_page.dart';
import 'package:faceapp/Pages/Home/people_page.dart';
import 'package:faceapp/Pages/Home/profile_page.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  static const backgroundColor = Color.fromRGBO(31, 29, 54, 1);
  static const navigationbarColor = Color.fromRGBO(134, 72, 121, 1);

  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(style: TextStyle(color: Colors.white), "FaceApp"),
        backgroundColor: backgroundColor,
        actions: const [
          IconButton(
              onPressed: signUserOut,
              icon: Icon(color: Colors.white, Icons.search))
        ],
      ),
      backgroundColor: backgroundColor,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(index: index)),
      bottomNavigationBar: CurvedNavigationBar(
        color: navigationbarColor,
        index: index,
        animationDuration: const Duration(milliseconds: 400),
        backgroundColor: backgroundColor,
        items: const [
          Icon(
            Icons.group,
            color: Colors.white,
          ),
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.person, color: Colors.white)
        ],
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const PeoplePage();
        break;
      case 1:
        widget = const HomePage();
        break;
      default:
        widget = const ProfilePage();
        break;
    }
    return widget;
  }
}
