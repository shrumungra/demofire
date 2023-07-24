import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController phone = TextEditingController();
  TextEditingController otp = TextEditingController();

// Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
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
              TextField(
                  controller: otp,
                  decoration: InputDecoration(hintText: "otp")),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: "+91" + phone.text,
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {
                        if (e.code == 'invalid-phone-number') {
                          print('The provided phone number is not valid.');
                        }
                      },
                      codeSent:
                          (String verificationId, int? resendToken) async {},
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                    print("=============send");
                  },
                  child: Text("send otp")),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: "+91" + phone.text,
                      verificationCompleted: (PhoneAuthCredential credential) {
                        print("===========complete");
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        print("===========failed");
                      },
                      codeSent:
                          (String verificationId, int? resendToken) async {
                        // Update the UI - wait for the user to enter the SMS code
                        String smsCode = otp.text;
                        print("===========codesent");

                        // Create a PhoneAuthCredential with the code
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: smsCode);

                        // Sign the user in (or link) with the credential
                        await FirebaseAuth.instance
                            .signInWithCredential(credential);
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        print("===========timeout");

                      },
                    );
                  },
                  child: Text("submit")),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
