import 'package:chatapp/pages/lgoinPg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  void logout() async {
    await FirebaseAuth.instance.signOut();
    //
    Navigator.popUntil(context, (route) => route.isFirst);

    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => Login_Page()));
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            IconButton(
                onPressed: () {
                  logout();
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Bhatsup"),
      ),
    );
  }
}
