

import 'package:flutter/material.dart';
import '../constants.dart';

class ProfiledetailItem extends StatelessWidget {
  final String imageUrl;
  final String farmName;
  final String farmDescription;
  final String firstLastName;
  final String email;
  final String phone;
  final String location;

  ProfiledetailItem({
    required this.imageUrl,
    required this.farmName,
    required this.farmDescription,
    required this.firstLastName,
    required this.email,
    required this.phone,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kmngprofilecolor,
        title: Row(
          children: [
            Image.asset(
              'assets/tractor.png',
              width: 45,
              height: 45,
            ),
            SizedBox(width: 5),
            Text('Farm Details'),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 50,
            child: Image.network(imageUrl),
          ),
          SizedBox(height: 16),
          buildInfoCard('Farm Name:', farmName),
          SizedBox(height: 16),
          buildInfoCard('First & Last Name:', firstLastName),
          SizedBox(height: 16),
          buildInfoCard('Email:', email),
          SizedBox(height: 16),
          buildInfoCard('Phone Number:', phone),
          SizedBox(height: 16),
          buildInfoCard('Location:', location),
          SizedBox(height: 16),
          buildInfoCard('Description:', farmDescription),
        ],
      ),
    );
  }

  Widget buildInfoCard(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 165, 205, 251),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 80, 94, 101),
              ),
            ),
            SizedBox(height: 7),
            Text(
              value,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
