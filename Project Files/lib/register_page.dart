import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faceapp/Components/button.dart';
import 'package:faceapp/Components/text_field.dart';

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
      // Show message here
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
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
                "Hemen kayıt ol",
                style: TextStyle(color: Colors.grey[700]),
              ),

              const SizedBox(
                height: 25,
              ),

              MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false),

              const SizedBox(
                height: 10,
              ),

              MyTextField(
                  controller: passwordTextController,
                  hintText: 'Şifre',
                  obscureText: true),

              const SizedBox(
                height: 10,
              ),

              MyTextField(
                  controller: confirmPasswordTextController,
                  hintText: 'Şifrenizi Tekrar Giriniz',
                  obscureText: true),

              const SizedBox(
                height: 25,
              ),

              MyButton(
                onTap: signUp,
                buttonText: "Kayıt Ol",
              ),

              const SizedBox(
                height: 25,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Zaten bir hesabın var mı?",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Hemen giriş yap",
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
