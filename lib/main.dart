import 'package:docspot/pages/dashboard.dart';
import 'package:docspot/pages/form_page.dart';
import 'package:docspot/pages/login_page.dart';
import 'package:docspot/pages/main_page.dart';
import 'package:docspot/pages/notification.dart';
import 'package:docspot/pages/signup_page.dart';
import 'package:docspot/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primary,
      ),
      initialRoute: MyRoutes.mainRoute,
      routes: {
        "/": (context) => const MainPage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.signupRoute: (context) => const SignUpPage(),
        MyRoutes.mainRoute: (context) => const MainPage(),
        MyRoutes.formRoute: (context) => const FormPage(),
        MyRoutes.dashboardRoute: (context) => DoctorSearchPage(),
        MyRoutes.notificationRoute: (context) => NotificationPage(),
      },
    );
  }
}
