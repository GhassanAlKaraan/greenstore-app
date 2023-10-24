// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:sharekniapp/screens/login.screens.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 30),
                  Transform.scale(
                      scale: 1.5,
                      child: const Text(
                        "Forgot \npassword?",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                ],
              ),
              const SizedBox(height:20),
              Text(
                "No worries! \nPlease enter your email address below, and we'll send you a password reset link.",
                style: TextStyle(color: Colors.grey.shade700,fontSize:16),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const  SizedBox(width:20),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      onChanged: (value) {
                        setState(() {
                          // _email = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email Field',
                        hintText: "Enter Your Email here",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        var email = passwordController.text.trim();
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email)
                              .then((value) => {
                                    print("email Sent!"),
                                    //Get.off(() => LoginScreen()),
                                  });
                        } on FirebaseAuthException catch (e) {
                          print("error $e");
                        }
                      },
                      child: const Text('Reset Password'),
                    ),
                  ),

                ],
              ),


            const   Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
