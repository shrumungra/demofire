import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class view1 extends StatefulWidget {
  const view1({super.key});

  @override
  State<view1> createState() => _view1State();
}

class _view1State extends State<view1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        Flexible(
          child: FirebaseAnimatedList(
            query: FirebaseDatabase.instance
                .ref()
                .child("Shruti")
                .orderByChild("email"),
            itemBuilder: (context, snapshot, animation, index) {
              print(
                  "P============================${snapshot.value.toString()}");
              Map map = snapshot.value as Map;
              return ListTile(
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(map['imageurl'])),
                title: Text("${map['number']}"),
              );
            },
          ),
        )
      ]),
    ));
  }
}
