import 'dart:developer';

import 'package:chatapp/models/ChatRoomModel.dart';
import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/pages/ChatRoom.dart';
import 'package:chatapp/widgets/noResultsFound.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

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
  TextEditingController searchController = TextEditingController();

  Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participants.${widget.userModel.uid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      // Will fetch existing
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatroom;
    } else {
      log("chatroom does not exist");
      ChatRoomModel newChatroom =
          ChatRoomModel(chatroomid: uuid.v1(), lastMessage: "", participants: {
        widget.userModel.uid.toString(): true,
        targetUser.uid.toString(): true,
      });

      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatroom.chatroomid)
          .set(newChatroom.toMap());

      chatRoom = newChatroom;

      log("New Chatroom createdd");
    }

    return chatRoom;
  }

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
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Email",
                          ),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          setState(() {});
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
          //
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("email", isEqualTo: searchController.text)
                .where("email", isNotEqualTo: widget.userModel.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                  if (dataSnapshot.docs.length > 0) {
                    Map<String, dynamic> userMap =
                        dataSnapshot.docs[0].data() as Map<String, dynamic>;

                    UserModel searchedUser = UserModel.fromMap(userMap);

                    return Container(
                        height: size.height * 0.094,
                        width: size.width * 0.9,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 193, 251, 195),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ListTile(
                          onTap: () async {
                            ChatRoomModel? chatroomModel =
                                await getChatroomModel(searchedUser);

                            if (chatroomModel != null) {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                return ChatRoomPage(
                                    chatroom: chatroomModel,
                                    firebaseUser: widget.firebaseUser,
                                    targetUser: searchedUser,
                                    userModel: widget.userModel);
                              })));
                            }
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Color.fromARGB(255, 155, 231, 157),
                            backgroundImage:
                                NetworkImage(searchedUser.profilepic!),
                          ),
                          title: Text(searchedUser.fullname!),
                          subtitle: Text(searchedUser.email!),
                          trailing: Icon(Icons.message),
                        ));
                  } else {
                    return NoResultsFound();
                  }
                } else if (snapshot.hasError) {
                  return Text("An error occured!");
                } else {
                  return Text("No results found!");
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
