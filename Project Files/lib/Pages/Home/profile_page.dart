import 'package:flutter/material.dart';

import '../../Components/profile_page_box.dart';

class ProfilePage extends StatelessWidget {
  static const backgroundColor = Color.fromRGBO(31, 29, 54, 1);

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: screenSize.height * 0.08,
                backgroundColor: const Color.fromRGBO(233, 166, 166, 1),
                child: const Icon(
                    Icons.person,
                    size: 100,
                    color: Color.fromRGBO(31, 29, 54, 1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Eren Başpınar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const ProfilePageBox(
                  icon: Icons.key,
                  text: "Account"
              ),
              const SizedBox(height: 10,),
              const ProfilePageBox(
                  icon: Icons.settings,
                  text: "Settings"
              ),

            ]
        ),
      ),),
      backgroundColor: backgroundColor,
    );
  }
}
