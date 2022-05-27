import 'package:flutter/material.dart';

class NoChats_HomePg extends StatelessWidget {
  const NoChats_HomePg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage("assets/images/makenewfriends.png"),
        ),
        Text("Make New Friends, search them by their email address")
      ],
    );
  }
}
