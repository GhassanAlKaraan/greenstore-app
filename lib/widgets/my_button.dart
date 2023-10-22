import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onPressed;

  const Mybutton({
    required this.color,
    required this.title,
    required this.onPressed, required int fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: Material(
        elevation: 5,
        color:color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed:  onPressed,
          minWidth: 140,
          height: 42,
          child: Text(title, style: TextStyle(color: Colors.white),),
          ),
      ),
    );
  }
}