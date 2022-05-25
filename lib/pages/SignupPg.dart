import 'dart:developer';

import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/pages/CompleteProfile.dart';
import 'package:chatapp/pages/loginPg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp_Page extends StatefulWidget {
  const SignUp_Page({Key? key}) : super(key: key);

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
  //
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      const snackBar = SnackBar(
        content: Text('Please fill all the details!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (password != cPassword) {
      const snackBar = SnackBar(
        content: Text('Passwords do not match!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      signUp(email, password);
    }
  }

  void signUp(String email, String password) async {
    UserCredential? credential;

    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
      const snackBar = SnackBar(
        content: Text("error, try changing email or password"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (credential != null) {
      String uid = credential.user!.uid;

      UserModel newUser =
          UserModel(uid: uid, email: email, fullname: "", profilepic: "");

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap())
          .then((value) {
        print("New User Created");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Cprofile_Page(
              userModel: newUser, firebaseUser: credential!.user!);
        }));
      });
    }
  }

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
              Image.asset("assets/images/SignupPg.png"),
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
                      child: TextField(
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
                      child: TextField(
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
              const SizedBox(height: 15),
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
                      child: TextField(
                        controller: cPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Confirm Password",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //
              //

              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, bottom: 10, left: 30),
                  child: InkWell(
                    child: const Text("Already have an account?"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

              //

              //
              InkWell(
                onTap: () {
                  createAccount();
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
                  child: Text("Sign Up",
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
