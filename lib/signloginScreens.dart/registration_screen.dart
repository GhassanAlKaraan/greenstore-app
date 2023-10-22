// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greenstore_app/screens/homefarmer_screen.dart';
import 'package:greenstore_app/signloginScreens.dart/signin_screen.dart';


import 'package:greenstore_app/widgets/my_button.dart';
import '../constants.dart';
import '../widgets/buildtextfiled.dart';

class RegistrationScreen extends StatefulWidget {
  static const String screenroutes = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _farmename = TextEditingController();
   String _userID = "";
  

  void _signup() async {
    String email = _email.text;
    String password = _password.text;
    String confirmPassword = _password.text; 
  

    if (password.length < 6) {
      print('Password should be at least 6 characters long');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password should be at least 6 characters long'),
      ));
      return; // Stop further execution
    }

    if (password == confirmPassword) {
      try {
        // Create a user in Firebase Authentication
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        _userID = userCredential.user!.uid;

        // Save additional user details to Firestore
        await _firestore.collection('farmers').add({
          'email': email,
          'farmename': _farmename.text,
          'userID': _userID,
        });

        

        // Show a success message to the user
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Signup Successful'),
        ));

        // Navigate to the home page
        Navigator.pushNamed(context, HomefarmerScreen.screenroutes);
      } catch (e) {
        print('Signup failed: $e');
      }
    } else {
      print('Passwords do not match');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Passwords do not match'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kgreencolor,
        title: Row(
          children: [
            Image.asset(
              'assets/tractor.png',
              width: 45,
              height: 45,
            ),
            const SizedBox(width: 5),
            const Text('Registration Farmer screen'),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _globalKey,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(height: 150),
            SizedBox(
              height: 100,
              child: Image.asset('assets/tractorbig2logo.png'),
            ),
            const SizedBox(height: 20),
            buildTextField(
              'Enter the Name Of your Farme',
              Icons.holiday_village_sharp,
              false,
              (value) {
                setState(() {
                  _farmename.text = value;
                });
              },
            ),
           
            buildTextField(
              'Enter your email',
              Icons.email,
              false,
              (value) {
                setState(() {
                  _email.text = value;
                });
              },
            ),
            buildTextField(
              'Enter your password',
              Icons.password,
              true, // Password field should be obscured
              (value) {
                setState(() {
                  _password.text = value;
                });
              },
            ),
           
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Mybutton(
                color: Kgreencolor,
                title: 'register',
                onPressed: () async {
                  if (_farmename.text.isNotEmpty &&
                      _email.text.isNotEmpty &&
                      _password.text.isNotEmpty) {
                    _signup();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please complete all the fields and select an image.'),
                    ));
                  }
                },
                fontSize: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Row(
                children: [
                  const Text('Have you an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignInScreen.screenRoute);
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Kgreencolor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
