import 'dart:io';

import 'package:chatapp/models/UIHelper.dart';
import 'package:chatapp/pages/loginPg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../models/UserModel.dart';
import 'HomePage.dart';

class Profile_Page extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const Profile_Page(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  File? imageFile;

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 20);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
      checkValues();
    }
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.gallery);
                  },
                  leading: const Icon(Icons.photo_album),
                  title: const Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take a photo"),
                )
              ],
            ),
          );
        });
  }

  void checkValues() {
    if (imageFile == null) {
      const snackBar = SnackBar(
        content: Text("Please choose a profile picture!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      uploadData();
    }
  }

  void uploadData() async {
    UIHelper.showLoadingDialog(context, "You are loaking good!");

    UploadTask uploadTask = FirebaseStorage.instance
        .ref("profilepictures")
        .child(widget.userModel.uid.toString())
        .putFile(imageFile!);

    TaskSnapshot snapshot = await uploadTask;

    String? imageUrl = await snapshot.ref.getDownloadURL();

    widget.userModel.profilepic = imageUrl;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel.uid)
        .set(widget.userModel.toMap())
        .then((value) {
      //
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Profile_Page(
                firebaseUser: widget.firebaseUser,
                userModel:
                    widget.userModel)), // this mainpage is your page to refresh
        (Route<dynamic> route) => false,
      );
    });
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => Profile_Page(
              firebaseUser: widget.firebaseUser,
              userModel:
                  widget.userModel)), // this mainpage is your page to refresh
      (Route<dynamic> route) => false,
    );
  }

//
  void logOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
      return Login_Page();
    })));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 155, 231, 157),
              image: DecorationImage(
                  image: AssetImage("assets/images/profilebg.png"))),
          child: Column(
            children: [
              const SizedBox(
                height: 140,
              ),
              Container(
                height: size.height * 0.48,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 17,
                          spreadRadius: 7)
                    ],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 2, color: Colors.white30)),
                child: Column(
                  children: [
                    //
                    //
                    const SizedBox(
                      height: 20,
                    ),
//
//
                    CupertinoButton(
                      onPressed: () {
                        showPhotoOptions();
                      },
                      child: Stack(children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor:
                              const Color.fromARGB(255, 193, 251, 195),
                          backgroundImage: NetworkImage(
                              widget.userModel.profilepic.toString()),
                        ),
                        const Positioned(
                            bottom: 0,
                            right: 12,
                            child: Icon(
                              Icons.add_circle,
                              size: 25,
                              color: Colors.green,
                            ))
                      ]),
                    ),
//
//
                    const SizedBox(
                      height: 15,
                    ),
//
//
                    Text(
                      widget.userModel.fullname.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
//
//
                    const SizedBox(
                      height: 7.0,
                    ),
//
//
                    Text(
                      widget.userModel.email.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
//
//
                    const SizedBox(
                      height: 28.0,
                    ),
//
//
                    InkWell(
                      onTap: () {
                        logOut();
                      },
                      child: Container(
                        height: 40,
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
                        child: Text("Log Out",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black.withOpacity(0.75))),
                      ),
                    ),
                  ],
                ),
              ),
//
              const SizedBox(
                height: 7.0,
              ),
//

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage(
                        userModel: widget.userModel,
                        firebaseUser: widget.firebaseUser);
                  }));
                },
                //
                child: const Icon(Icons.arrow_back_ios_new_outlined,
                    color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.all(17),
                  primary: Colors.white.withOpacity(0.4), // <-- Button color
                  onPrimary: Colors.lightGreen, // <-- Splash color
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
