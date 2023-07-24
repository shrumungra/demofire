import 'package:demofire/Otp.dart';
import 'package:demofire/register.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                  controller: phone,
                  decoration: InputDecoration(hintText: "number")),
              TextField(controller: pass,decoration: InputDecoration(hintText: "password")),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return reg();
                      },
                    ));
                  },
                  child: Text("signup")),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Otp();
                      },
                    ));
                  },
                  child: Text("otp")),
              ElevatedButton(onPressed: () {}, child: Text("login"))
            ],
          ),
        ),
      ),
    );
  }
}
