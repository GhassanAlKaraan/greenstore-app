import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messageme_app/constants.dart';

class farmdetailsscreen extends StatefulWidget {
  static const String screenroutes = 'farmesDetailsScreen';
  const farmdetailsscreen({super.key});

  @override
  State<farmdetailsscreen> createState() => _farmdetailsscreenState();
}
class _farmdetailsscreenState extends State<farmdetailsscreen> {
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
      final String farmId = "معرف المزرعة الذي تم النقر عليه في الصفحة السابقة";
      _loadFarmData(farmId);
    });
  }

  void _loadFarmData(String farmId) {
    // اجلب بيانات المزرعة من Firestore باستخدام farmId
    FirebaseFirestore.instance.collection('farmersprofile').doc(farmId).get().then((DocumentSnapshot snapshot) {
      final Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
   if (data != null) {
     email = data['email'] as String?;
     farmDescription = data['farmedescription'] as String?;
     farmName = data['farmename'] as String?;
     firstLastName = data['firstlastname'] as String?;
     location = data['location'] as String?;
     phone = data['phone'] as String?;
     profileImageUrl = data['profileImageUrl'] as String?;
}

    });}

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
            Text('Farme Details'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
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
