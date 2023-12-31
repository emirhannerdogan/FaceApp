import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faceapp/Database/firestore_helper.dart';
import 'package:faceapp/Database/local_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faceapp/Components/button.dart';
import 'package:rive/rive.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      Navigator.pop(context);
      LocalHelper.saveUserEmail(emailTextController.text);
      FirestoreHelper firestoreHelper =
          FirestoreHelper(uid: userCredential.user!.uid);
      LocalHelper.saveUserId(userCredential.user!.uid);
      QuerySnapshot userData =
          await firestoreHelper.getUserData(emailTextController.text);

      if (userData.docs.isNotEmpty) {
        LocalHelper.saveUserName(userData.docs[0].get('name'));
        String downloadURL = userData.docs[0].get('recogPic');
        await firestoreHelper.downloadAndSaveProfilePicture(
            userCredential.user!.uid, downloadURL);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'network-request-failed') {
        networkErrorMessage();
      } else if (e.code == 'too-many-requests') {
        tooManyAttemptsMessage();
      } else {
        wrongUserMessage();
      }
    }
  }

  void wrongUserMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("User not found"),
            content: const Text(
                "Please make sure your e-mail and password are correct."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  void tooManyAttemptsMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Too many attempts"),
            content: const Text(
                "Due to wrong password attempts, your account has been temporarily disabled. Please try again later."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  void networkErrorMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Network error"),
            content: const Text(
                "Please check your internet connection and try again later."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width,
                  height: 200,
                  child: RiveAnimation.asset(
                    'assets/login_char.riv',
                    stateMachines: const ["Login Machine"],
                    onInit: (artboard) {
                      controller = StateMachineController.fromArtboard(
                          artboard, "Login Machine");
                      if (controller == null) return;

                      artboard.addController(controller!);
                      isChecking = controller?.findInput("isChecking");
                      isHandsUp = controller?.findInput("isHandsUp");
                      trigSuccess = controller?.findInput("trigSuccess");
                      trigFail = controller?.findInput("trigFail");
                    },
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    if (isHandsUp != null) {
                      isHandsUp!.change(false);
                    }
                    if (isChecking == null) return;

                    isChecking!.change(true);
                  },
                  controller: emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    prefixIcon: const Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    if (isChecking != null) {
                      isChecking!.change(false);
                    }
                    if (isHandsUp == null) return;

                    isHandsUp!.change(true);
                  },
                  controller: passwordTextController,
                  obscureText: true, // to hide password
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                // Logo
                //const Icon(Icons.lock, size: 100),
                /*
                Text(
                  "Tekrar hoşgeldin, seni özledik.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
          */
                const SizedBox(
                  height: 25,
                ),

                MyButton(
                  onTap: signUserIn,
                  buttonText: "Log in",
                ),

                const SizedBox(
                  height: 25,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member yet?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Create account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ))
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
