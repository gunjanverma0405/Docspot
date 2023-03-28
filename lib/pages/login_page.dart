import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/firebase_auth_methods.dart';
import '../utils/routes.dart';
import '../utils/showSnackBar.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    if (emailController.value.text.isNotEmpty ||
        passwordController.value.text.isNotEmpty) {
      FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context);
      Navigator.pushNamed(context, MyRoutes.dashboardRoute);
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
                "assets/images/login_image.png",
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Text(
                "Welcome back!",
                style: const TextStyle(
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
                        onTap: loginUser,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          width: 250,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      width: 200.0,
                      child: Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const <Widget>[
                              Icon(
                                FontAwesomeIcons.solidEnvelope,
                                color: Color(0xFF00BFA6),
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                "New User? Sign up now!",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00BFA6),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, MyRoutes.signupRoute);
                          },
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
