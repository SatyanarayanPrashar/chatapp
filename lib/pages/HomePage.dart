import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/pages/ProfileView.dart';
import 'package:chatapp/pages/SearchPage.dart';
import 'package:chatapp/pages/loginPg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        children: [
//
          Container(
            height: 104,
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
                const SizedBox(height: 32),
                Row(children: [
                  //

                  CupertinoButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile_Page()),
                      );
                    },
                    child: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),

                  //
                  Spacer(),
                  //
                  CupertinoButton(
                    child: Icon(
                      Icons.search,
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
    );
  }
}
