import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenstore_app/signloginScreens.dart/resetpage.dart';
import 'package:greenstore_app/signloginScreens.dart/welcome_screen.dart';
import '../constants.dart';
import '../screens/homefarmer_screen.dart';
import '../widgets/buildtextfiled.dart';
import '../widgets/my_button.dart';

class SignInScreen extends StatefulWidget {
  static const String screenRoute = 'signin_screen';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found for that email");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No user found for that email"),
          ),
        );
      } else if (e.code == "wrong-password") {
        print("Invalid password");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid password"),
          ),
        );
      }
    }
    return user;
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
    final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
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
            SizedBox(width: 5),
            Text('Sign in screen'),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            Container(
              child: Image.asset('assets/tractorbiglogo.png'),
              height: 190,
            ),
            SizedBox(height: 8),
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
                  "Forgot Password?",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Mybutton(
                color: Color.fromARGB(255, 250, 116, 161),
                title: 'Sign in',
                onPressed: () async {
                  User? user = await loginUsingEmailPassword(
                    email: emailController.text,
                    password: passwordController.text,
                    context: context,
                  );
                  print(user);
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomefarmerScreen()),
                    );
                  }
                },
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Row(
                children: [
                  Text('Do not have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, WelcomeScreen.screenroutes);
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Kpinkcolor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

