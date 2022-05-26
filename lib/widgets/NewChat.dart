import 'package:flutter/material.dart';

class NewChat extends StatelessWidget {
  const NewChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.3,
        width: size.width * 0.5,
        child: Column(
          children: [
            Image.asset("assets/images/newChat.png"),
            Text("Say Hello to your new friend"),
          ],
        ));
  }
}
