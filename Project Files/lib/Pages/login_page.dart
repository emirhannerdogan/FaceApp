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
        });
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text, password: passwordTextController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      body: SafeArea(
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
                  hintText: "E mail",
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
    );
  }
}
