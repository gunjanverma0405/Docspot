import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firebase_auth_methods.dart';
import '../utils/routes.dart';
import '../utils/showSnackBar.dart';
import '../widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUpUser() async {
    if (emailController.value.text.isNotEmpty ||
        passwordController.value.text.isNotEmpty) {
      FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context);
      Navigator.pushNamed(context, MyRoutes.formRoute);
    } else {
      showSnackBar(context, "Fill all the details");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Image.asset(
                "assets/images/signup_image.png",
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00BFA6),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 32.0,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextField(
                        controller: emailController,
                        hintText: 'Enter your email',
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextField(
                        controller: passwordController,
                        hintText: 'Enter your password',
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Material(
                      color: Color(0xFF00BFA6),
                      elevation: 5,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: signUpUser,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          width: 250,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
