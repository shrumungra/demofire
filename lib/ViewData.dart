import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: ForgetttingDataFromFirebasde(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("==${snapshot.data}");
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                subtitle: Text("${snapshot.data![index]['number']}"),
                leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage("${snapshot.data![index]['imageurl']}")),
                title: Text("${snapshot.data![index]['email']}"),
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    ));
  }

  Future<List> ForgetttingDataFromFirebasde() async {

    DatabaseReference ref = FirebaseDatabase.instance.ref("Shruti");
    DatabaseEvent de = await ref.once(DatabaseEventType.value);

    print(de.snapshot.value);

    Map map = de.snapshot.value as Map;
    List dataa = [];

    map.forEach((key, value) {
      // print("$key==========");
      dataa.add(value);
    });
    print("=======$dataa");
    print("====333===${dataa[1]}");

    return dataa;
  }
}
