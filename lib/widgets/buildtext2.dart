import 'package:flutter/material.dart';
import 'package:messageme_app/constants.dart';

// Define the _errormsg function outside of buildTextField
String _errormsg(String hintText) {
  switch (hintText) {
    case 'Enter the Name Of your Product':
      return 'Name is empty!';
    case 'Enter the price of this unit':
      return 'Price is empty!';
    case 'Enter a Description of this product':
      return 'Description is empty!';
    case 'Enter the category of this product(vegetables, fruits, animals, seeds and wood)':
      return 'Category is empty!';
    case 'Enter the image of the product':
      return 'Image is needed!';
    default:
      return 'Unknown error';
  }
}

Widget buildtext2(String hintText, IconData? prefixIcon, Function(String?) onClick) {
  String? text = ''; // Create a variable to store text input

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return _errormsg(hintText);
        }
      },
      onTap: () {
        onClick(text); // Call the onClick function with the current text
      },
      onChanged: (value) {
        text = value; // Update the text variable when text changes
      },
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Kpinkcolor,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 255, 230, 0),
            width: 3,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: OutlineInputBorder(
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

