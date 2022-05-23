import 'package:chatapp/pages/SignupPg.dart';
import 'package:flutter/material.dart';

class Login_Page extends StatelessWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: const Color.fromARGB(255, 155, 231, 157),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
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
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(7),
                      height: 25,
                      width: 40,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/email.png"),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      height: 45,
                      width: 200,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //
              //
              const SizedBox(height: 15),
              //
              //
              Container(
                height: 45,
                width: 317,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 193, 251, 195),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(7),
                      height: 25,
                      width: 40,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/password.png"),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      height: 45,
                      width: 200,
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //
              const SizedBox(
                height: 10,
              ),
              //
              Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  InkWell(
                    child: const Text("Forgot Password?"),
                    onTap: () {
                      //
                    },
                  ),
                  const Spacer(),
                  InkWell(
                    child: const Text("Sign Up!"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp_Page()),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                ],
              ),
              //
              const SizedBox(
                height: 10,
              ),
              //
              InkWell(
                onTap: () {
                  //
                },
                child: Container(
                  height: 45,
                  width: 121,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 251, 244),
                          blurRadius: 11.0,
                          spreadRadius: 1.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(14),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 112, 163, 245),
                            Color.fromARGB(255, 0, 255, 123),
                          ])),
                  alignment: Alignment.center,
                  child: Text("Log in",
                      style: TextStyle(
                          fontSize: 20, color: Colors.black.withOpacity(0.75))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
