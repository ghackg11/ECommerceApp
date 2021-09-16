import 'package:ecommerce/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/home_page.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: const MaterialColor(0xFF29C17E, <int, Color>{50: Color(0xFF29C17E), 100: Color(0xFF29C17E)})
      ),
      home: FirebaseAuth.instance.currentUser==null? LoginPage():  HomePage(),
    );
  }
}

