import 'dart:io';

import 'package:flutter/material.dart';
import '../../Components/profile_page_box.dart';
import '../../Database/local_helper.dart';
import 'package:faceapp/Pages/Login/camera_page.dart';
import '../../Database/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  final Function()? refreshProfile;
  const ProfilePage({Key? key, this.refreshProfile}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _userNameController = TextEditingController();
  String userName = "User";
  bool isEditing = false;
  String? profilePicture;

  static const backgroundColor = Color.fromRGBO(31, 29, 54, 1);

  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
  }

  Future<void> _loadProfilePicture() async {
    final picture = await LocalHelper.getProfilePicture();
    setState(() {
      profilePicture = picture;
    });
  }

  void startEditing() async {
    String? savedUserName = await LocalHelper.getUserName();
    setState(() {
      isEditing = true;
      _userNameController.text = savedUserName ?? '';
    });
  }

  void saveChanges() async {
    setState(() {
      isEditing = false;
      userName = _userNameController.text;
    });

    await LocalHelper.saveUserName(userName);

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String currentUserId = user.uid;
      FirestoreHelper firestoreHelper = FirestoreHelper(uid: currentUserId);
      await firestoreHelper.updateUserName(userName);
    }
  }

  void navigateToCameraPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CameraPage(
                refreshProfile: _loadProfilePicture,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<dynamic>(
            future: LocalHelper.getUserName().then((value) => value.toString()),
            builder: (context, snapshot) {
              String userName = snapshot.data ?? "User";
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: screenSize.height * 0.08,
                        backgroundColor: const Color.fromRGBO(233, 166, 166, 1),
                        child: profilePicture != null
                            ? ClipOval(
                                child: Image.file(
                                  File(profilePicture!),
                                  fit: BoxFit.cover,
                                  width: screenSize.height *
                                      0.16, // Adjust image size
                                  height: screenSize.height *
                                      0.16, // Adjust image size
                                ),
                              )
                            : const Icon(
                                Icons.person,
                                size: 100,
                                color: Color.fromRGBO(31, 29, 54, 1),
                              ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          navigateToCameraPage(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        isEditing ? '' : userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      isEditing
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: _userNameController,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.save,
                                      size: 20,
                                      color: Color.fromRGBO(233, 166, 166, 1)),
                                  onPressed: saveChanges,
                                ),
                              ],
                            )
                          : IconButton(
                              icon: const Icon(Icons.edit,
                                  size: 20,
                                  color: Color.fromRGBO(233, 166, 166, 1)),
                              onPressed: startEditing,
                            ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const ProfilePageBox(icon: Icons.key, text: "Account"),
                  const SizedBox(height: 10),
                  const ProfilePageBox(icon: Icons.settings, text: "Settings"),
                ],
              );
            },
          ),
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
