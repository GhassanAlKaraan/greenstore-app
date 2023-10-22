

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

  const ProfiledetailItem({super.key, 
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
            const SizedBox(width: 5),
            const Text('Farm Details'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 50,
            child: Image.network(imageUrl),
          ),
          const SizedBox(height: 16),
          buildInfoCard('Farm Name:', farmName),
          const SizedBox(height: 16),
          buildInfoCard('First & Last Name:', firstLastName),
          const SizedBox(height: 16),
          buildInfoCard('Email:', email),
          const SizedBox(height: 16),
          buildInfoCard('Phone Number:', phone),
          const SizedBox(height: 16),
          buildInfoCard('Location:', location),
          const SizedBox(height: 16),
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
          color: const Color.fromARGB(255, 165, 205, 251),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 80, 94, 101),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              value,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
