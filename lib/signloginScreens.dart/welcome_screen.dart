import 'package:flutter/material.dart';

import 'package:messageme_app/signloginScreens.dart/registration_screen.dart';
import 'package:messageme_app/signloginScreens.dart/registrationclient_scrreen.dart';

import 'package:messageme_app/signloginScreens.dart/signin_screen.dart';
import '../widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenroutes = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 230),
              child: Container(
                height: 150,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/tractorbig2logo.png'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right:10 ),
              child: Mybutton(
                color: Color.fromARGB(255, 250, 116, 161),
                title: 'Sign in',
                onPressed: () {
                  Navigator.pushNamed(context, SignInScreen.screenRoute);
                },
                 fontSize: 50,
              ),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right:10 ),
              child: Mybutton(
                color: const Color.fromARGB(255, 255, 230, 0),
                title: 'Register',
                onPressed: () {
                  setState(() {
                    selectedRole = 'select_role';
                  });
                },
                 fontSize: 50,

              ),
            ),
            SizedBox(height: 8,),
            Visibility(
              visible: selectedRole != null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.screenroutes);
                    },
                    child: Text('Farmer'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationclientScreen.screenroutes);
                    },
                    child: Text('Client'),
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
