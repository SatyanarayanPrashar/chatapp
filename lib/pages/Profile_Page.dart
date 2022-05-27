import 'package:chatapp/pages/loginPg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/UserModel.dart';

class Profile_Page extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const Profile_Page(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
//
  void logOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
      return Login_Page();
    })));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 155, 231, 157),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 155, 231, 157),
              image: DecorationImage(
                  image: AssetImage("assets/images/profilebg.png"))),
          child: Column(
            children: [
              const SizedBox(
                height: 140,
              ),
              Container(
                height: size.height * 0.42,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 17,
                          spreadRadius: 7)
                    ],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 2, color: Colors.white30)),
                child: Column(
                  children: [
                    //
                    const SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: const Color.fromARGB(255, 193, 251, 195),
                      backgroundImage:
                          NetworkImage(widget.userModel.profilepic.toString()),
                    ),
                    //
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.userModel.fullname.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    //
                    const SizedBox(
                      height: 7.0,
                    ),
                    Text(
                      widget.userModel.email.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                    //
                    const SizedBox(
                      height: 28.0,
                    ),
                    InkWell(
                      onTap: () {
                        logOut();
                      },
                      child: Container(
                        height: 45,
                        width: 121,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 164, 251, 244),
                                blurRadius: 11.0,
                                spreadRadius: 1.0,
                              )
                            ],
                            borderRadius: BorderRadius.circular(14),
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 112, 163, 245),
                                  Color.fromARGB(255, 0, 255, 123),
                                ])),
                        alignment: Alignment.center,
                        child: Text("Log Out",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black.withOpacity(0.75))),
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
