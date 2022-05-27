import 'package:flutter/material.dart';

class NoChats_HomePg extends StatelessWidget {
  const NoChats_HomePg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      width: size.width * 0.8,
      child: Column(
        children: [
          Image(
            image: AssetImage("assets/images/makenewfriends.png"),
          ),
          Text("Make New Friends"),
          Text("search them by their email address")
        ],
      ),
    );
  }
}
