import 'package:flutter/material.dart';

import '../../Components/profile_page_box.dart';
import '../../Database/local_helper.dart';

class ProfilePage extends StatefulWidget {


  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _userNameController = TextEditingController();
  String userName = "User";
  bool isEditing = false;

  static const backgroundColor = Color.fromRGBO(31, 29, 54, 1);

  void _startEditing() {
    setState(() {
      isEditing = true;
      _userNameController.text = userName;
    });
  }

  void _saveChanges() {
    setState(() {
      isEditing = false;
      userName = _userNameController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<dynamic>(
            future: LocalHelper.getUserName().then((value) => value.toString()),
            builder: (context, snapshot){
              String userName = snapshot.data ?? "User";
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: screenSize.height * 0.08,
                    backgroundColor: const Color.fromRGBO(233, 166, 166, 1),
                    child: const Icon(
                      Icons.person,
                      size: 100,
                      color: Color.fromRGBO(31, 29, 54, 1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 50,),
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
                          Container(
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
                            icon: Icon(Icons.save, size: 20, color: Color.fromRGBO(233, 166, 166, 1)),
                            onPressed: _saveChanges,
                          ),
                        ],
                      )
                          : IconButton(
                        icon: Icon(Icons.edit, size: 20, color: Color.fromRGBO(233, 166, 166, 1)),
                        onPressed: _startEditing,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const ProfilePageBox(icon: Icons.key, text: "Account"),
                  const SizedBox(height: 10),
                  const ProfilePageBox(icon: Icons.settings, text: "Settings"),
                ],
              );
            }
          ),
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
