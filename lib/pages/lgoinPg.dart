import 'package:flutter/material.dart';

class Login_Page extends StatelessWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Color.fromARGB(255, 155, 231, 157),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.09),
            Image.asset("assets/images/loginPg.png"),
            SizedBox(height: size.height * 0.03),
            //
            //
            Container(
              height: 45,
              width: 317,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 193, 251, 195),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10, top: 11),
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                ),
              ),
            ),
            //
            //
            SizedBox(height: size.height * 0.03),
            //
            //
            Container(
              height: 45,
              width: 317,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 193, 251, 195),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10, top: 11),
                  prefixIcon: Icon(Icons.password),
                  hintText: "Password",
                ),
              ),
            ),
            //
            //
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 30),
                child: InkWell(
                  child: Text("Forgot Password?"),
                  onTap: () {
                    //
                  },
                ),
              ),
            ),
            //
            //
            Container()
          ],
        ),
      ),
    );
  }
}
