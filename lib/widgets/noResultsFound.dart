import 'package:flutter/material.dart';

class NoResultsFound extends StatelessWidget {
  const NoResultsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      width: size.width * 0.87,
      child: Column(
        children: [
          Image.asset(
            "assets/images/noResults.png",
            height: size.height * 0.25,
          ),
          Text("NO Results Found"),
        ],
      ),
    );
  }
}
