import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'ViewData.dart';

class reg extends StatefulWidget {
  const reg({super.key});

  @override
  State<reg> createState() => _regState();
}

class _regState extends State<reg> {
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  String imagepath = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      imagepath = image!.path;
                    });
                  },
                  child: CircleAvatar(
                    maxRadius: 60,
                    backgroundImage: FileImage(File(imagepath)),
                  )),
              TextField(
                  controller: phone,
                  decoration: InputDecoration(hintText: "number")),
              TextField(
                  controller: email,
                  decoration: InputDecoration(hintText: "email")),
              TextField(
                  controller: pass,
                  decoration: InputDecoration(hintText: "pass")),
              ElevatedButton(
                  onPressed: () async {
                    // try {
                    //   final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    //     email: email.text,
                    //     password: pass.text,
                    //
                    //   );
                    //   print('==========${credential.user}');
                    //
                    // } on FirebaseAuthException catch (e) {
                    //   if (e.code == 'weak-password') {
                    //     print('The password provided is too weak.');
                    //   } else if (e.code == 'email-already-in-use') {
                    //     print('The account already exists for that email.');
                    //   }
                    // } catch (e) {
                    //   print("=======$e===");
                    // }

                    // storage

                    // final storageRef = FirebaseStorage.instance.ref();
                    // String imagename = "Image${DateTime.now().second}.jpg";
                    // final spaceRef = storageRef.child("ShrutiImagess/${imagename}");
                    // await spaceRef.putFile(File(imagee));
                    // spaceRef.getDownloadURL().then((value) async {
                    //
                    //   DatabaseReference ref = FirebaseDatabase.instance.ref("Mydata").push();
                    //   String? id = ref.key;
                    //   await ref.set({
                    //     "id":id,
                    //     "name": "John1",
                    //     "imageurl" : value
                    //   });
                    //   print("====${value}");
                    // });

                    final storageRef = FirebaseStorage.instance.ref();
                    String imagename = "image:${DateTime.now().second}.jpg";
                    final spaceRef = storageRef.child("Allimages/${imagename}");

                    await spaceRef.putFile(File(imagepath));

                    await spaceRef.getDownloadURL().then((value) async {
                      print("======$value");

                      // database

                      DatabaseReference ref =
                          FirebaseDatabase.instance.ref("Shruti").push();

                      String? userid = ref.key;

                      await ref.set({
                        "userid": "${userid}",
                        "number": "${phone.text}",
                        "email": "${email.text}",
                        "password": "${pass.text}",
                        "imageurl": value,
                      }).then((value) {

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ViewData();
                          },
                        ));
                      });
                    });
                  },
                  child: Text("sign up"))
            ],
          ),
        ),
      ),
    );
  }
}
