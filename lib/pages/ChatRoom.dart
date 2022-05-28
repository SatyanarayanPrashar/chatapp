import 'dart:developer';
import 'package:chatapp/models/MessaggeModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';
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
  //
  TextEditingController messageController = TextEditingController();
  //
  void sendMessage() async {
    String msg = messageController.text.trim();
    messageController.clear();

    if (msg != null) {
      // send message
      MessageModel newMessage = MessageModel(
          messageid: uuid.v1(),
          sender: widget.userModel.uid,
          createdon: DateTime.now(),
          text: msg,
          seen: false);

      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatroom.chatroomid)
          .collection("messages")
          .doc(newMessage.messageid)
          .set(newMessage.toMap());

      widget.chatroom.lastMessage = msg;
//
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatroom.chatroomid)
          .set(widget.chatroom.toMap());

      log("message sent");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 155, 231, 157),
        title: Row(children: [
          CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 193, 251, 195),
            backgroundImage:
                NetworkImage(widget.targetUser.profilepic.toString()),
          ),
//
          const SizedBox(
            width: 10,
          ),
//
          Text(widget.targetUser.fullname.toString()),
        ]),
      ),
      body: SafeArea(
        child: Column(
          children: [
//
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
//
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatrooms")
                    .doc(widget.chatroom.chatroomid)
                    .collection("messages")
                    .orderBy("createdon", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot dataSnapshot =
                          snapshot.data as QuerySnapshot;

                      return ListView.builder(
                        reverse: true,
                        itemCount: dataSnapshot.docs.length,
                        itemBuilder: (context, index) {
                          MessageModel currentMessage = MessageModel.fromMap(
                              dataSnapshot.docs[index].data()
                                  as Map<String, dynamic>);

                          return Row(
                            mainAxisAlignment:
                                (currentMessage.sender == widget.userModel.uid)
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: (currentMessage.sender ==
                                            widget.userModel.uid)
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(14),
                                            topRight: Radius.circular(14),
                                            bottomLeft: Radius.circular(14))
                                        : const BorderRadius.only(
                                            topLeft: Radius.circular(14),
                                            topRight: Radius.circular(14),
                                            bottomRight: Radius.circular(14)),
                                    color: (currentMessage.sender ==
                                            widget.userModel.uid)
                                        ? Color.fromARGB(255, 209, 247, 210)
                                        : Color.fromARGB(255, 155, 231, 157),
                                  ),
                                  child: Text(
                                    currentMessage.text.toString(),
                                    style: const TextStyle(fontSize: 18),
                                  )),
                            ],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                          "An error Occured! Please check your internet connection.");
                    } else {
                      return Center(child: Text("say hi to ur friend"));
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )),
//
            Container(
              color: Color.fromARGB(255, 209, 247, 210),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(children: [
                Flexible(
                    child: TextField(
                  maxLines: null,
                  controller: messageController,
                  decoration: const InputDecoration(
                    hintText: "Enter message",
                    border: InputBorder.none,
                  ),
                )),
                IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: Icon(Icons.send))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
