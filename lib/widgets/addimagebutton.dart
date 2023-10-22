import 'package:flutter/material.dart';

import 'package:messageme_app/constants.dart';

class addimagebutton extends StatelessWidget {
  final VoidCallback onPressed;

  addimagebutton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: Kpinkcolor, width: 2.0),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 27),
              child: Icon(
                Icons.camera_alt,
                color: Color.fromARGB(255, 132, 129, 129),
              ),
            ),
            SizedBox(width: 5),
            Text(
              'Upload an image',
              style: TextStyle(
                color: Color.fromARGB(255, 116, 110, 110),
              ),
            ),
            
          ],
          
        ),
      ),
    );
  }
}
