import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greenstore_app/constants.dart';

class FarmDetailsScreen extends StatefulWidget {
  static const String screenroutes = 'farmesDetailsScreen';
  const FarmDetailsScreen({super.key});

  @override
  State<FarmDetailsScreen> createState() => _FarmDetailsScreenState();
}

class _FarmDetailsScreenState extends State<FarmDetailsScreen> {
  String? email;
  String? farmDescription;
  String? farmName;
  String? firstLastName;
  String? location;
  String? phone;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    // قم بجلب بيانات المزرعة من Firestore باستخدام معرف المزرعة
    // استخدم Future.delayed للتأكد من أن البيانات قد تم جلبها بنجاح قبل إعادة إنشاء واجهة المستخدم
    Future.delayed(Duration.zero, () {
      const String farmId = "معرف المزرعة الذي تم النقر عليه في الصفحة السابقة";
      _loadFarmData(farmId);
    });
  }

  void _loadFarmData(String farmId) {
    // اجلب بيانات المزرعة من Firestore باستخدام farmId
    FirebaseFirestore.instance
        .collection('farmersprofile')
        .doc(farmId)
        .get()
        .then((DocumentSnapshot snapshot) {
      final Map<String, dynamic>? data =
          snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        email = data['email'] as String?;
        farmDescription = data['farmedescription'] as String?;
        farmName = data['farmename'] as String?;
        firstLastName = data['firstlastname'] as String?;
        location = data['location'] as String?;
        phone = data['phone'] as String?;
        profileImageUrl = data['profileImageUrl'] as String?;
      }
    });
  }

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
            const Text('Farme Details'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CircleAvatar(child: Image.network(profileImageUrl ?? '')),

            Text('Email: $email'),
            Text('Farm Description: $farmDescription'),
            Text('Farm Name: $farmName'),
            Text('First & Last Name: $firstLastName'),
            Text('Location: $location'),
            Text('Phone: $phone'),
          ],
        ),
      ),
    );
  }
}
