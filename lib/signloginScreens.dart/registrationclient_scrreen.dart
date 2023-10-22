// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greenstore_app/screens/homeclient_screen.dart'; // تحديد الشاشة الرئيسية للعميل

import 'package:greenstore_app/signloginScreens.dart/signin_screen.dart';
import 'package:greenstore_app/widgets/my_button.dart';
import '../constants.dart';
import '../widgets/buildtextfiled.dart';

class RegistrationclientScreen extends StatefulWidget {
  static const String screenroutes = 'registrationclient_screen';

  const RegistrationclientScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationclientScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationclientScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _firstlastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _location = TextEditingController();

  String _userID = "";
  //final TextEditingController _location = TextEditingController();

  void _signup() async {
    String email = _email.text;
    String password = _password.text;
    String firstlastName = _firstlastname.text; 
   // String lastName = _firstlastname.text;
    String phone = _phone.text;
    String location = _location.text;
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

        //! Update the user profile - to be checked
        userCredential.user!.updateProfile(displayName:location);
        //userCredential.user!.updateProfile(displayName:firstlastName);
        //userCredential.user!.updateProfile(displayName:phone);

      // Save additional user details to Firestore for clients
      await _firestore.collection('clients').add({
        'email': email,
        'firstlastName': firstlastName,
        'phone': phone,
        'userID': _userID,
        'location': location,
       });

      // Show a success message to the user
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Signup Successful'),
      ));

      // Navigate to the home page for clients
      Navigator.pushNamed(context,HomeclientScreen.screenroutes);
    } catch (e) {
      print('Signup failed: $e');
      // Add code to show an error message to the user (e.g., a Snackbar)
    }
  }

  else {
      print('Passwords do not match');
      // Add code to show an error message to the user (e.g., a Snackbar)
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
            const Text('Registration Client screen'), // تغيير عنوان الشاشة إلى "Registration Client screen"
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _globalKey,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(height: 25),
            SizedBox(
              height: 100,
              child: Image.asset('assets/tractorbig2logo.png'),
            ),
            const SizedBox(height: 50),
            buildTextField(
              'Enter your first and last name',
              Icons.title_rounded,
              false,
              (value) {
                setState(() {
                  _firstlastname.text = value;
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
            buildTextField(
              'Enter your phone number',
              Icons.phone,
              false,
              (value) {
                setState(() {
                  _phone.text = value;
                });
              },
            ),
            buildTextField(
              'Enter your location',
              Icons.location_on,
              false, 
              (value) {
                setState(() {
                  _location.text = value;
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
                  if (_firstlastname.text.isNotEmpty &&
                      _email.text.isNotEmpty &&
                      _phone.text.isNotEmpty &&
                      _password.text.isNotEmpty&&
                      _location.text.isNotEmpty
                      ) {
                    
                    _signup();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please complete all the fields.'),
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

