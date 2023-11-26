import 'package:faceapp/Database/local_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faceapp/Components/button.dart';
import 'package:faceapp/Components/text_field.dart';
import 'package:faceapp/Database/firestore_helper.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void signUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    if (passwordTextController.text != confirmPasswordTextController.text) {
      Navigator.pop(context);
      passwordMatchMessage();
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      await FirestoreHelper(uid: FirebaseAuth.instance.currentUser!.uid)
          .registerUser(emailTextController.text);
      LocalHelper.saveUserName(emailTextController.text);
      LocalHelper.saveUserEmail(emailTextController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'network-request-failed') {
        networkErrorMessage();
      } else if (e.code == 'invalid-email') {
        invalidEmailMessage();
      } else if (e.code == 'email-already-in-use') {
        emailAlreadyUsedMessage();
      } else if (e.code == 'weak-password') {
        weakPasswordMessage();
      } else {
        generalErrorMessage();
      }
    }
  }

  void passwordMatchMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Passwords do not match"),
            content: const Text(
                "Please make sure your passwords match and try again."),
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

  void emailAlreadyUsedMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("E-mail already in use"),
            content: const Text(
                "Please use another e-mail or log in to your account."),
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

  void weakPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Weak password"),
            content: const Text(
                "Please make sure your password is at least 6 characters long and try again later."),
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

  void invalidEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Invalid E-mail"),
            content: const Text(
                "Please make sure your e-mail is correct and try again later."),
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

  void generalErrorMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text(
                "Please try again later. If the problem persists, please contact us"),
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
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const Icon(Icons.lock, size: 100),

                const SizedBox(
                  height: 50,
                ),

                Text(
                  "SIGN UP NOW!",
                  style: TextStyle(color: Colors.grey[700]),
                ),

                const SizedBox(
                  height: 25,
                ),

                MyTextField(
                    controller: emailTextController,
                    hintText: 'E-mail',
                    obscureText: false),

                const SizedBox(
                  height: 10,
                ),

                MyTextField(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true),

                const SizedBox(
                  height: 10,
                ),

                MyTextField(
                    controller: confirmPasswordTextController,
                    hintText: 'Enter password again',
                    obscureText: true),

                const SizedBox(
                  height: 25,
                ),

                MyButton(
                  onTap: signUp,
                  buttonText: "Sign up",
                ),

                const SizedBox(
                  height: 25,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a user?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Log in",
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
