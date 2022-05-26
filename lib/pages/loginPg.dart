import 'dart:developer';

import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/pages/HomePage.dart';
import 'package:chatapp/pages/SignupPg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  //
  //
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "") {
      const snackBar = SnackBar(
        content: Text('Please give an email adress!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (password == "") {
      const snackBar = SnackBar(
        content: Text('Please set a password!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      logIn(email, password);
    }
  }

  void logIn(String email, String password) async {
    UserCredential? credential;

    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
      const snackBar = SnackBar(
        content: Text("Please check your email or password!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (credential != null) {
      String uid = credential.user!.uid;

      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      UserModel userModel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);
      //
      // Go to HomePaage
      print("Log In successful!");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage(userModel: userModel, firebaseUser: credential!.user!);
      }));
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: const Color.fromARGB(255, 155, 231, 157),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.09),
              Image.asset("assets/images/loginPg.png"),
              SizedBox(height: size.height * 0.03),
              //
              //
              Container(
                height: 45,
                width: 317,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 193, 251, 195),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(7),
                      height: 25,
                      width: 40,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/email.png"),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      height: 45,
                      width: 200,
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //
              //
              const SizedBox(height: 15),
              //
              //
              Container(
                height: 45,
                width: 317,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 193, 251, 195),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(7),
                      height: 25,
                      width: 40,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/password.png"),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      height: 45,
                      width: 200,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //
              const SizedBox(
                height: 10,
              ),
              //
              Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  InkWell(
                    child: const Text("Forgot Password?"),
                    onTap: () {
                      //
                    },
                  ),
                  const Spacer(),
                  InkWell(
                    child: const Text("Sign Up!"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp_Page()),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                ],
              ),
              //
              const SizedBox(
                height: 10,
              ),
              //
              InkWell(
                onTap: () {
                  checkValues();
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
                  child: Text("Log in",
                      style: TextStyle(
                          fontSize: 20, color: Colors.black.withOpacity(0.75))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
