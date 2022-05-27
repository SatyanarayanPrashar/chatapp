import 'package:chatapp/models/UserModel.dart';
// import 'package:chatapp/pages/ProfileView.dart';
import 'package:chatapp/pages/SearchPage.dart';
import 'package:chatapp/pages/loginPg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Profile_Page.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const HomePage(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

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
        context, CupertinoPageRoute(builder: (context) => const Login_Page()));
  }

  //
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //
            Container(
              height: 77,
              width: size.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 155, 231, 157),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
              ),
              //
              child: Column(
                children: [
                  // const SizedBox(height: 32),
                  Row(children: [
                    //

                    CupertinoButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile_Page(
                                  userModel: widget.userModel,
                                  firebaseUser: widget.firebaseUser)),
                        );
                      },
                      child: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ),

                    //
                    const Spacer(),
                    //
                    CupertinoButton(
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Search_Page(
                                  firebaseUser: widget.firebaseUser,
                                  userModel: widget.userModel)),
                        );
                      },
                    ),
                  ]),
                ],
              ),
            )
//
          ],
        ),
      ),
    );
  }
}
