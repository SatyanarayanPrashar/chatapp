import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/ChatRoomModel.dart';
import '../models/UserModel.dart';

class ChatRoomPage extends StatefulWidget {
  final UserModel targetUser;
  final ChatRoomModel chatroom;
  final UserModel userModel;
  final User firebaseUser;

  const ChatRoomPage(
      {Key? key,
      required this.targetUser,
      required this.chatroom,
      required this.userModel,
      required this.firebaseUser})
      : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.greenAccent,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
//
              Expanded(child: Container()),
//
              Container(
                color: Colors.lightGreenAccent,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(children: [
                  Flexible(
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter message",
                      border: InputBorder.none,
                    ),
                  )),
                  IconButton(onPressed: () {}, icon: Icon(Icons.send))
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
