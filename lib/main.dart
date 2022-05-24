import 'package:chatapp/pages/CompleteProfile.dart';
import 'package:chatapp/pages/HomePage.dart';
import 'package:chatapp/pages/loginPg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        // home: (FirebaseAuth.instance.currentUser != null)
        //     ? Login_Page()
        //     : Login_Page());
        home: Cprofile_Page());
  }
}
