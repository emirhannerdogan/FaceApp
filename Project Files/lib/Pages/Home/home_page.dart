import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faceapp/Components/home_page_message_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// sign out için kullanılacak kod
void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class _HomePageState extends State<HomePage> {
  static const backgroundColor = Color.fromRGBO(31, 29, 54, 1);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 5,),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HomePageMessageBox(
                            username: 'Alper Özdemir',
                            message: 'Emirhan bu ödevi yapamaz',
                            shortName: 'AÖ',
                          ),
                          SizedBox(height: 10),
                          HomePageMessageBox(
                            username: 'Emirhan Erdoğan',
                            message: 'Alper yine zorla spora götürdü',
                            shortName: 'EE',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HomePageMessageBox(
                            username: 'Eren Başpınar',
                            message: 'Bizi kimse sevmedi albayım',
                            shortName: 'EB',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HomePageMessageBox(
                            username: 'Eren Başpınar',
                            message: 'Bizi kimse sevmedi albayım',
                            shortName: 'EB',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HomePageMessageBox(
                            username: 'Eren Başpınar',
                            message: 'Bizi kimse sevmedi albayım',
                            shortName: 'EB',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HomePageMessageBox(
                            username: 'Eren Başpınar',
                            message: 'Bizi kimse sevmedi albayım',
                            shortName: 'EB',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HomePageMessageBox(
                            username: 'Eren Başpınar',
                            message: 'Bizi kimse sevmedi albayım',
                            shortName: 'EB',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HomePageMessageBox(
                            username: 'Eren Başpınar',
                            message: 'Bizi kimse sevmedi albayım',
                            shortName: 'EB',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HomePageMessageBox(
                            username: 'Eren Başpınar',
                            message: 'Bizi kimse sevmedi albayım',
                            shortName: 'EB',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HomePageMessageBox(
                            username: 'Eren Başpınar',
                            message: 'Bizi kimse sevmedi albayım',
                            shortName: 'EB',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HomePageMessageBox(
                            username: 'Eren Başpınar',
                            message: 'Bizi kimse sevmedi albayım',
                            shortName: 'EB',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HomePageMessageBox(
                            username: 'Eren Başpınar',
                            message: 'Bizi kimse sevmedi albayım',
                            shortName: 'EB',
                          )
                        ]),
                  ),
                ),
              ),
              SizedBox(height: 15,)
            ]
          ),),
      backgroundColor: backgroundColor,
    );
  }
}
