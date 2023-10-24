// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:messageme_app/constants.dart';
// import 'package:messageme_app/screens/product.dart';
// import 'package:path/path.dart' as p;
// import 'package:provider/provider.dart';

// class ManageProfileScreen extends StatefulWidget {
//   static const String screenRoute = 'manage_profile_screen';

//   const ManageProfileScreen({Key? key}) : super(key: key);

//   @override
//   State<ManageProfileScreen> createState() => _ManageProfileScreenState();
// }

// class _ManageProfileScreenState extends State<ManageProfileScreen> {
//   final _firestore = FirebaseFirestore.instance;
//   final TextEditingController _farmeName = TextEditingController();
//   final TextEditingController _firstLastName = TextEditingController();
//   final TextEditingController _farmeDescription = TextEditingController();
//   final TextEditingController _phone = TextEditingController();
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _location = TextEditingController();
//   File? _image;

//    String userId = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Image.asset(
//               'assets/tractor.png',
//               width: 45,
//               height: 45,
//             ),
//             SizedBox(width: 5),
//             Text('Add your Farm'),
//           ],
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.close,
//               color: Colors.white,
//             ),
//           )
//         ],
//       ),
//       body: ListView(
//         children: [
//           SizedBox(height: 50),
//           CircleAvatar(
//             radius: 60,
//             backgroundImage: _image == null
//                 ? AssetImage('assets/noooprofile.jpg') as ImageProvider
//                 : FileImage(_image!),
//           ),
//           SizedBox(height: 5),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 190),
//             child: GestureDetector(
//               child: Icon(Icons.camera_alt),
//               onTap: pickImage,
//             ),
//           ),
//           SizedBox(height: 20),
//           _buildTextField(
//             'Enter the Name Of your Farm',
//             Icons.holiday_village_sharp,
//             _farmeName,
//           ),
//           _buildTextField(
//             'Enter your first and last name',
//             Icons.title_rounded,
//             _firstLastName,
//           ),
//           _buildTextField(
//             'Enter a description about your farm',
//             Icons.description,
//             _farmeDescription,
//           ),
//           _buildTextField(
//             'Enter your email',
//             Icons.email,
//             _email,
//           ),
//           _buildTextField(
//             'Enter your phone number',
//             Icons.phone,
//             _phone,
//           ),
//           _buildTextField(
//             'Enter your location',
//             Icons.location_on,
//             _location,
//           ),
//           SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 100),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.green, // Change to your desired color
//               ),
//               onPressed: () async {
//                 Provider.of<ProductList>(context, listen: false).setFarmID(userId);

//                 if (_image != null &&
//                     _farmeName.text.isNotEmpty &&
//                     _firstLastName.text.isNotEmpty &&
//                     _farmeDescription.text.isNotEmpty &&
//                     _email.text.isNotEmpty &&
//                     _phone.text.isNotEmpty &&
//                     _location.text.isNotEmpty) {
//                   try {
//                     // Upload the image to Firebase Storage
//                     final storageRef = firebase_storage.FirebaseStorage.instance
//                         .ref()
//                         .child('profile_images/${p.basename(_image!.path)}');

//                     await storageRef.putFile(_image!);

//                     // Get the download URL of the uploaded image
//                     final imageUrl = await storageRef.getDownloadURL();

//                     // Add data to Firestore
//                      User? user = FirebaseAuth.instance.currentUser;
//                     String? farmID = user?.uid;
//                     await _firestore.collection('farmersprofile').add({
//                       'email': _email.text,
//                       'farmedescription': _farmeDescription.text,
//                       'farmename': _farmeName.text,
//                       'firstlastname': _firstLastName.text,
//                       'location': _location.text,
//                       'phone': _phone.text,
//                       'profileImageUrl': imageUrl,
//                        'userID': userId,
//                     });

//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text('Success'),
//                           content: Text('Your farm has been successfully established.'),
//                           actions: <Widget>[
//                             TextButton(
//                               child: Text('OK', selectionColor: Kpinkcolor,),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );

//                      Provider.of<ProductList>(context, listen: false).setFarmID(farmID!);
//                   } catch (error) {
//                     // Handle errors, e.g., show an error message
//                     print('Error: $error');
//                   }
//                 }
//               },
//               child: Text('Done'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon),
//         ),
//       ),
//     );
//   }

//   Future<void> pickImage() async {
//     var image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _image = File(image.path);
//       });
//     }
//   }
// }

// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:greenstore_app/constants.dart';
import 'package:path/path.dart' as p;

class ManageProfileScreen extends StatefulWidget {
  static const String screenRoute = 'manage_profile_screen';

  const ManageProfileScreen({Key? key}) : super(key: key);

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _farmeName = TextEditingController();
  final TextEditingController _firstLastName = TextEditingController();
  final TextEditingController _farmeDescription = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _location = TextEditingController();
  File? _image;
  String? farmID;

  @override
  void initState() {
    super.initState();
    retrieveFarmID();
  }

  Future<void> retrieveFarmID() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userId = user?.uid;

    final farmRef = FirebaseFirestore.instance
        .collection('farmers')
        .where('userId', isEqualTo: userId);
    final farmSnapshot = await farmRef.get();

    if (farmSnapshot.docs.isNotEmpty) {
      farmID = farmSnapshot.docs.first.id;
    } else {
      final newFarmRef = FirebaseFirestore.instance.collection('farmers');
      final newFarmDoc = await newFarmRef.add({
        'userId': userId,
      });
      farmID = newFarmDoc.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/tractor.png',
              width: 45,
              height: 45,
            ),
            const SizedBox(width: 5),
            const Text('Add your Farm'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          CircleAvatar(
            radius: 60,
            backgroundImage: _image == null
                ? const AssetImage('assets/noooprofile.jpg') as ImageProvider
                : FileImage(_image!),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 190),
            child: GestureDetector(
              onTap: pickImage,
              child: const Icon(Icons.camera_alt),
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            'Enter the Name Of your Farm',
            Icons.holiday_village_sharp,
            _farmeName,
          ),
          _buildTextField(
            'Enter your first and last name',
            Icons.title_rounded,
            _firstLastName,
          ),
          _buildTextField(
            'Enter a description about your farm',
            Icons.description,
            _farmeDescription,
          ),
          _buildTextField(
            'Enter your email',
            Icons.email,
            _email,
          ),
          _buildTextField(
            'Enter your phone number',
            Icons.phone,
            _phone,
          ),
          _buildTextField(
            'Enter your location',
            Icons.location_on,
            _location,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // قم بتغييرها للون الزر المفضل لديك
              ),
              onPressed: () async {
                if (_image != null &&
                    _farmeName.text.isNotEmpty &&
                    _firstLastName.text.isNotEmpty &&
                    _farmeDescription.text.isNotEmpty &&
                    _email.text.isNotEmpty &&
                    _phone.text.isNotEmpty &&
                    _location.text.isNotEmpty) {
                  try {
                    // قم برفع الصورة إلى Firebase Storage
                    final storageRef = firebase_storage.FirebaseStorage.instance
                        .ref()
                        .child('profile_images/${p.basename(_image!.path)}');
                    await storageRef.putFile(_image!);

                    // احصل على عنوان URL للصورة المرفوعة
                    final imageUrl = await storageRef.getDownloadURL();

                    // أضف البيانات إلى Firestore
                    User? user = FirebaseAuth.instance.currentUser;
                    //! to check
                    String? userId = user?.uid;

                    await _firestore.collection('farmersprofile').add({
                      'email': _email.text,
                      'farmedescription': _farmeDescription.text,
                      'farmename': _farmeName.text,
                      'firstlastname': _firstLastName.text,
                      'location': _location.text,
                      'phone': _phone.text,
                      'profileImageUrl': imageUrl,
                      'farmID': farmID,
                    });

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Success'),
                          content: const Text(
                              'Your farm has been successfully established.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'OK',
                                selectionColor: Kpinkcolor,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } catch (error) {
                    // التعامل مع الأخطاء، مثل عرض رسالة خطأ
                    print('Error: $error');
                  }
                }
              },
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
}
