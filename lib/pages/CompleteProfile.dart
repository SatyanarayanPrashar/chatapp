import 'dart:io';
import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/pages/HomePage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Cprofile_Page extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const Cprofile_Page(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<Cprofile_Page> createState() => Cprofile_PageState();
}

class Cprofile_PageState extends State<Cprofile_Page> {
//
  File? imageFile;
  TextEditingController fullNameController = TextEditingController();

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
    }
  }

//
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
    String fullname = fullNameController.text.trim();

    if (fullname == "") {
      const snackBar = SnackBar(
        content: Text("Please fill a Username!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (imageFile == null) {
      const snackBar = SnackBar(
        content: Text("Please choose a profile picture!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      uploadData();
    }
  }

  void uploadData() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("profilepictures")
        .child(widget.userModel.uid.toString())
        .putFile(imageFile!);

    TaskSnapshot snapshot = await uploadTask;

    String? imageUrl = await snapshot.ref.getDownloadURL();
    String? fullname = fullNameController.text.trim();

    widget.userModel.fullname = fullname;
    widget.userModel.profilepic = imageUrl;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel.uid)
        .set(widget.userModel.toMap())
        .then((value) {
      print("Data uploaded!");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return HomePage(
              userModel: widget.userModel, firebaseUser: widget.firebaseUser);
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 155, 231, 157),
          image: DecorationImage(
              image: AssetImage("assets/images/Cprofileo.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.25,
              ),
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Container(
                  height: size.height * 0.42,
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
//
//
                  child: Column(children: [
//
                    const SizedBox(height: 20),

                    CupertinoButton(
                      onPressed: () {
                        showPhotoOptions();
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            (imageFile != null) ? FileImage(imageFile!) : null,
                        child: (imageFile == null)
                            ? const Icon(
                                Icons.person,
                                size: 60,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 10.0),
//
//
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 45,
                      width: 317,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 193, 251, 195),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 17),
                          SizedBox(
                            height: 45,
                            width: 200,
                            child: TextFormField(
                              controller: fullNameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Userame",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5.0),
//
//
                    InkWell(
                      onTap: () {
                        checkValues();
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
                        child: Text("Submit",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black.withOpacity(0.75))),
                      ),
                    ),
//
//
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
