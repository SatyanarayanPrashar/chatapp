import 'package:chatapp/models/ChatRoomModel.dart';
import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/models/fireBaseHealper.dart';
import 'package:chatapp/pages/ChatRoom.dart';
// import 'package:chatapp/pages/ProfileView.dart';
import 'package:chatapp/pages/SearchPage.dart';
import 'package:chatapp/pages/loginPg.dart';
import 'package:chatapp/widgets/NoChats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      appBar: AppBar(
          title: Text(widget.userModel.fullname.toString()),
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 155, 231, 157),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.userModel.profilepic.toString()),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Search_Page(
                              firebaseUser: widget.firebaseUser,
                              userModel: widget.userModel)),
                    );
                  },
                  icon: const Icon(Icons.search, color: Colors.white, size: 30),
                ),
              ],
            )
          ]),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chatrooms")
                .where("participants.${widget.userModel.uid}", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot chatRoomSnapshot =
                      snapshot.data as QuerySnapshot;

                  return ListView.builder(
                    itemCount: chatRoomSnapshot.docs.length,
                    itemBuilder: (context, index) {
                      ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                          chatRoomSnapshot.docs[index].data()
                              as Map<String, dynamic>);

                      Map<String, dynamic> participants =
                          chatRoomModel.participants!;

                      List<String> participantKeys = participants.keys.toList();
                      participantKeys.remove(widget.userModel.uid);

                      return FutureBuilder(
                        future:
                            FirebaseHelper.getUserModelById(participantKeys[0]),
                        builder: (context, userData) {
                          if (userData.connectionState ==
                              ConnectionState.done) {
                            if (userData.data != null) {
                              UserModel targetUser = userData.data as UserModel;

                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return ChatRoomPage(
                                        chatroom: chatRoomModel,
                                        firebaseUser: widget.firebaseUser,
                                        userModel: widget.userModel,
                                        targetUser: targetUser,
                                      );
                                    }),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      targetUser.profilepic.toString()),
                                ),
                                title: Text(targetUser.fullname.toString()),
                                subtitle: (chatRoomModel.lastMessage
                                            .toString() !=
                                        "")
                                    ? Text(chatRoomModel.lastMessage.toString())
                                    : Text(
                                        "Say hi to your new friend!",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: Text("No Chats"),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
