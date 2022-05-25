import 'package:chatapp/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search_Page extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const Search_Page(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<Search_Page> createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 155, 231, 157),
        title: Text("Search"),
      ),
      body: Column(
        children: [
//
          Container(
            height: 55,
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
                Container(
                  height: 45,
                  width: size.width * 0.9,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 193, 251, 195),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 45,
                        width: size.width * 0.7,
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "search Email",
                          ),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          //
                        },
                        child: const Icon(Icons.search),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
  //

  //
          const SizedBox(height: 20),

          StreamBuilder(
            builder: ,
          ),
        ],
      ),
//
    );
  }
}
