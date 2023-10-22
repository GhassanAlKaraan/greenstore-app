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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Column(
        children: [
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
                labelText: 'Email',
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
          ElevatedButton(
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
        ],
      ),
    );
  }
}