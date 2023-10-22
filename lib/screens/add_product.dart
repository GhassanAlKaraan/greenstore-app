// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:greenstore_app/constants.dart';
import 'package:greenstore_app/widgets/buildtextfiled.dart';
import 'dart:io';
import '../widgets/addimagebutton.dart';
import '../widgets/my_button.dart';
import 'homefarmer_screen.dart';
import 'manage_product_screen.dart';

class AddProductScreen extends StatefulWidget {
  static const String screenroutes = 'addproduct';

  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? farmId;
  //! to check
  final _firestore = FirebaseFirestore.instance;

  late final TextEditingController _productName = TextEditingController();
  late final TextEditingController _productPrice = TextEditingController();
  late final TextEditingController _productDescription =
      TextEditingController();

  String productId = UniqueKey().toString();

  File? fileImage;
  String selectedCategory = '';

  _showOption(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Make a choice'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () => _imagefromGallery(context),
              ),
              ListTile(
                leading: const Icon(Icons.camera_enhance),
                title: const Text('camera'),
                onTap: () => _imagefromcamera(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _imagefromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        fileImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  Future _imagefromcamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        fileImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kgreencolor,
        title: Row(
          children: [
            Image.asset(
              'assets/tractor.png',
              width: 45,
              height: 45,
            ),
            const SizedBox(width: 5),
            const Text('Add your product'),
          ],
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          AddImageButton(onPressed: () => _showOption(context)),
          buildTextField(
            'Enter the Name Of your Product',
            Icons.title_rounded,
            false,
            (value) {
              setState(() {
                _productName.text = value;
              });
            },
          ),
          buildTextField(
              'Enter the price of this unit', Icons.euro_outlined, false,
              (value) {
            setState(() {
              _productPrice.text = value;
            });
          }),
          buildTextField(
              'Enter a Description of this product', Icons.description, false,
              (value) {
            setState(() {
              _productDescription.text = value;
            });
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1.2,
                  color: Kpinkcolor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.category_outlined,
                        color: Color.fromARGB(255, 116, 110, 110),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Choose the category of your product',
                        style: TextStyle(
                          color: Color.fromARGB(255, 116, 110, 110),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Mybutton(
                        color: const Color.fromARGB(255, 136, 252, 140),
                        title: 'vegetables',
                        onPressed: () {
                          selectCategory('vegetables'); // تحديث الفئة المحددة
                        },
                        fontSize: 20,
                      ),
                      Mybutton(
                        color: const Color.fromARGB(255, 249, 124, 157),
                        title: 'Fruits',
                        onPressed: () {
                          selectCategory('Fruits'); // تحديث الفئة المحددة
                        },
                        fontSize: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Mybutton(
                        color: const Color.fromARGB(255, 255, 240, 108),
                        title: 'animals',
                        onPressed: () {
                          selectCategory('animals'); // تحديث الفئة المحددة
                        },
                        fontSize: 20,
                      ),
                      Mybutton(
                        color: const Color.fromARGB(255, 255, 214, 123),
                        title: 'seeds ',
                        onPressed: () {
                          selectCategory('seeds'); // تحديث الفئة المحددة
                        },
                        fontSize: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Mybutton(
                        color: const Color.fromARGB(255, 131, 188, 235),
                        title: 'Dairy Products',
                        onPressed: () {
                          selectCategory(
                              'Dairy Products'); // تحديث الفئة المحددة
                        },
                        fontSize: 20,
                      ),
                      Mybutton(
                        color: const Color.fromARGB(255, 245, 134, 94),
                        title: 'wood',
                        onPressed: () {
                          selectCategory('wood'); // تحديث الفئة المحددة
                        },
                        fontSize: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Mybutton(
                          color: const Color.fromARGB(255, 255, 163, 107),
                          title: 'Meat Products',
                          onPressed: () {
                            selectCategory(
                                'Meat Products'); // تحديث الفئة المحددة
                          },
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            child: Mybutton(
              color: Kgreencolor,
              title: 'Add Product',
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;
                String? userId = user?.uid;

                // التحقق من أن قيمة الفئة محددة
                if (selectedCategory.isNotEmpty) {
                  // رفع الصورة إلى Firebase Storage
                  if (fileImage != null) {
                    final storageReference = FirebaseStorage.instance
                        .ref()
                        .child('product_images')
                        .child(
                            'image_${DateTime.now().millisecondsSinceEpoch}.jpg');

                    final uploadTask = storageReference.putFile(fileImage!);

                    final TaskSnapshot uploadTaskSnapshot =
                        await uploadTask.whenComplete(() => null);

                    if (uploadTaskSnapshot.state == TaskState.success) {
                      final imageUrl = await storageReference.getDownloadURL();

                      // حفظ بيانات المنتج في Firestore بما في ذلك قيمة الفئة
                      CollectionReference collRef =
                          FirebaseFirestore.instance.collection('products');
                      await collRef.add({
                        'name': _productName.text,
                        'price': _productPrice.text,
                        'description': _productDescription.text,
                        'image_url': imageUrl,
                        'category': selectedCategory,
                        'farmuserId': userId,
                        'product_id': productId,
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Product '),
                            content: const Text(' Product added successfuly'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'ok',
                                  style: TextStyle(color: Kpinkcolor),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // معالجة فشل رفع الصورة إذا كان ذلك ضرورياً
                      print('Image upload failed');
                    }
                  } else {
                    // معالجة حالة عدم تحديد صورة
                    print('No image selected');
                  }
                } else {
                  // معالجة حالة عدم تحديد الفئة
                  print('Category not selected');
                }
              },
              fontSize: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Manage Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Home Farmer Screen',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: const Color.fromARGB(255, 132, 131, 131),
        unselectedItemColor: const Color.fromARGB(255, 132, 131, 131),
        onTap: (int index) {
          if (index == 0) {
            Navigator.of(context)
                .pushReplacementNamed(ManageProductScreen.screenroutes);
          } else if (index == 1) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomefarmerScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
