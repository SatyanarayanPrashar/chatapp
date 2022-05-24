import 'dart:developer';
import 'package:chatapp/pages/HomePage.dart';
import 'package:chatapp/pages/SignupPg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cprofile_Page extends StatefulWidget {
  const Cprofile_Page({Key? key}) : super(key: key);

  @override
  State<Cprofile_Page> createState() => Cprofile_PageState();
}

class Cprofile_PageState extends State<Cprofile_Page> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 155, 231, 157),
          image: DecorationImage(
              image: AssetImage("assets/images/Cprofileo.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.25,
              ),
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Container(
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
//
//
                  child: Column(children: [
//
                    const SizedBox(height: 20),

                    CupertinoButton(
                      onPressed: () {
                        //
                      },
                      child: const CircleAvatar(
                        radius: 60,
                        child: Icon(
                          Icons.person,
                          size: 60,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
//
//
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 45,
                      width: 317,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 193, 251, 195),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 17),
                          SizedBox(
                            height: 45,
                            width: 200,
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Userame",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5.0),

//
//
                    InkWell(
                      onTap: () {
                        //
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
                        child: Text("Submit",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black.withOpacity(0.75))),
                      ),
                    ),
//
//
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
