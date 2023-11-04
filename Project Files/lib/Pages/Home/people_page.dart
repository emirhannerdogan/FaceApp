import 'package:flutter/material.dart';

import '../../Components/home_page_message_box.dart';

class PeoplePage extends StatelessWidget {
  static const backgroundColor = Color.fromRGBO(31, 29, 54, 1);

  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(63, 51, 81, 1),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: SizedBox(
                      width: screenSize.width * 0.47,
                      height: screenSize.height * 0.09,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 5,),
                          Icon(Icons.people_alt_rounded, size: 25, color: Colors.white,),
                          SizedBox(width: 5,),
                          Text("New Group", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                        ],
                      )),
                ),
                SizedBox(width: 10,),
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(63, 51, 81, 1),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: SizedBox(
                      width: screenSize.width * 0.47,
                      height: screenSize.height * 0.09,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 5,),
                          Icon(Icons.add_circle, size: 25, color: Colors.white,),
                          SizedBox(width: 5,),
                          Text("New Friend", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                        ],
                      )
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: screenSize.width * 0.95,
              child: SearchBar(
                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white24),
                hintText: "Search",
                hintStyle: MaterialStateProperty.resolveWith((states) => TextStyle(color: Colors.white70)),
                textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(color: Colors.white)),
              ),),
            SizedBox(height: 10,),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Column(
                    children: [
                      HomePageMessageBox(
                        shortName: "AÖ",
                        username: "Alper Özdemir",
                        message: "Hey there! I am using FaceApp",),
                      SizedBox(height: 10,),
                      HomePageMessageBox(
                        shortName: "EE",
                        username: "Emirhan Erdoğan",
                        message: "Uyuyor",),
                      SizedBox(height: 10,),
                      HomePageMessageBox(
                        shortName: "EB",
                        username: "Eren Başpınar",
                        message: "💛💙",),
                      SizedBox(height: 10,),
                      HomePageMessageBox(
                        shortName: "EB",
                        username: "Eren Başpınar",
                        message: "💛💙",),
                      SizedBox(height: 10,),
                      HomePageMessageBox(
                        shortName: "EB",
                        username: "Eren Başpınar",
                        message: "💛💙",),
                      SizedBox(height: 10,),
                      HomePageMessageBox(
                        shortName: "EB",
                        username: "Eren Başpınar",
                        message: "💛💙",),
                      SizedBox(height: 10,),
                      HomePageMessageBox(
                        shortName: "EB",
                        username: "Eren Başpınar",
                        message: "💛💙",),SizedBox(height: 10,),
                      HomePageMessageBox(
                        shortName: "EB",
                        username: "Eren Başpınar",
                        message: "💛💙",),
                      SizedBox(height: 10,),
                      HomePageMessageBox(
                        shortName: "EB",
                        username: "Eren Başpınar",
                        message: "💛💙",),
                      SizedBox(height: 10,),
                      HomePageMessageBox(
                        shortName: "EB",
                        username: "Eren Başpınar",
                        message: "💛💙",),
                      SizedBox(height: 10,),
                      HomePageMessageBox(
                        shortName: "EB",
                        username: "Eren Başpınar",
                        message: "💛💙",),
                      SizedBox(height: 10,),
                      HomePageMessageBox(
                        shortName: "EB",
                        username: "Eren Başpınar",
                        message: "💛💙",),
              
                    ],
                  ),
                ),
              
              ),
            ),
            SizedBox(height: 15,)
          ]
        ),
      ),
    );
  }
}
