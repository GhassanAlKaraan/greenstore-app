import 'package:flutter/material.dart';

// Define the _errormsg function outside of buildTextField
String _errormsg(String hintText) {
  switch (hintText) {
    case 'enter your email':
      return 'email is empty!';
    case 'enter your password':
      return 'password is empty!';
    case 'Enter your username':
      return 'username is empty!';
    case 'Enter the name of your farm':
      return 'name of farm is empty!';
    case 'Enter your location':
      return 'location is empty!';
    default:
      return 'Unknown error';
  }
}

Widget buildTextField(String hintText, IconData? prefixIcon, bool obscureText, Function(String) onChanged) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return _errormsg(hintText);
        }
        return null;
      },
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 248, 147, 180),
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 255, 230, 0),
            width: 3,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 255, 0, 0),
            width: 3,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    ),
  );
}
