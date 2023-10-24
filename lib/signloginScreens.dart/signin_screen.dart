// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenstore_app/signloginScreens.dart/resetpage.dart';
import 'package:greenstore_app/signloginScreens.dart/welcome_screen.dart';
import '../constants.dart';
import '../presentation/asset_manager.dart';
import '../screens/homeclient_screen.dart';
import '../screens/homefarmer_screen.dart';
import '../widgets/buildtextfiled.dart';
import '../widgets/my_button.dart';

class SignInScreen extends StatefulWidget {
  static const String screenRoute = 'signin_screen';

  const SignInScreen({Key? key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}
class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  Future<void> _SignIn() async {
    final email = emailController.text;
    final password = passwordController.text;

    User? user = await loginUsingEmailPassword(
      email: email,
      password: password,
      context: context,
    );

    if (user != null) {
      bool isClient = await checkClient(email);
print(true);

      if (isClient) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeclientScreen()),
        );
      } else {
        print(false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomefarmerScreen()),
        );
      }
    }
  }

  Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No user found for that email"),
          ),
        );
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid password"),
          ),
        );
      }
    }
    return user;
  }

  Future<bool> checkClient(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot clientQuery =
    await firestore.collection('clients').where('email', isEqualTo: email).get();

    if (clientQuery.docs.isNotEmpty) {
      return true; // User is a client
    } else {
      return false; // User is not a client
    }
  }
  Future<void> resetPassword(String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset email sent"),
        ),
      );
    } catch (e) {
      print("Failed to send password reset email: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to send password reset email"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kpinkcolor,
        title: Row(
          children: [
            Image.asset(
              'assets/tractor.png',
              width: 45,
              height: 45,
            ),
            const SizedBox(width: 5),
            const Text('Sign in screen'),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: globalKey,
          child: ListView(
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                height: 190,
                child: Image.asset(AssetImages.logo),
              ),
              const SizedBox(height: 8),
              buildTextField('Enter your email', Icons.email, false, (value) {
                return emailController.text = value;
              }),
              buildTextField('Enter your password', Icons.lock, true, (value) {
                return passwordController.text = value;
              }),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetScreen(),
                    ),
                  );
                },
                child: const Text(
                  textAlign: TextAlign.right,
                  "Forgot Password?",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Mybutton(
                  color: const Color.fromARGB(255, 250, 116, 161),
                  title: 'Sign in',
                  onPressed: _SignIn,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, WelcomeScreen.screenroutes);
                      },
                      child: const Text(
                        'Register here',
                        style: TextStyle(
                            color: Kpinkcolor,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
