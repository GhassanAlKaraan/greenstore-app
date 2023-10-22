import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import '../widgets/farmedatailswidget.dart';
import '../widgets/my_button.dart';
import 'allproductscreen.dart';
import 'homeclient_screen.dart';

class FarmersProfilesScreen extends StatefulWidget {
   static const String screenroutes = 'farmersScreen';
  @override
  _FarmersProfilesScreenState createState() => _FarmersProfilesScreenState();
}

class _FarmersProfilesScreenState extends State<FarmersProfilesScreen> {
  
  final productsCollection = FirebaseFirestore.instance.collection('products');
  String selectedFarmId = ''; // State variable to store the selected farm's ID

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
            Text('Farmers Profiles'),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('farmersprofile').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          final farmers = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: farmers.length,
              itemBuilder: (context, index) {
                final farmerData = farmers[index].data() as Map<String, dynamic>?;

                if (farmerData == null) {
                  return SizedBox();
                }

                final imageUrl = farmerData['profileImageUrl'] ?? '';
                final farmName = farmerData['farmename'] ?? '';
                final farmDescription = farmerData['farmedescription'] ?? '';
                final firstLastName = farmerData['firstlastname'] ?? '';
                final email = farmerData['email'] ?? '';
                final phone = farmerData['phone'] ?? '';
                final location = farmerData['location'] ?? '';
                final farmId = farmers[index].id; // Get the farm's ID

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _showFarmerDetailsDialog(context, 
                      imageUrl,
                       farmName, 
                       farmDescription,
                        firstLastName,
                         email,
                          phone,
                           location,
                            farmId);
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                        SizedBox(height: 8),
                        Text(farmName),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showFarmerDetailsDialog(
    BuildContext context,
    String imageUrl,
    String farmName,
    String farmDescription,
    String firstLastName,
    String email,
    String phone,
    String location,
    String farmId,
  ) {
    // Set the selectedFarmId when a farm is selected
    setState(() {
      selectedFarmId = farmId;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Center(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                Text(farmName),
              ],
            ),
          ),
          children: <Widget>[
           Mybutton(color: Kpinkcolor, title: 'Categories', onPressed: () {
              Navigator.pushNamed(context, HomeclientScreen.screenroutes);
            }, fontSize: 50),
             Mybutton(color: kproductscreen, title: 'All Products', onPressed: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Allproductscreen(),
                ),
              );
            }, fontSize: 50),
             Mybutton(color: kmngprofilecolor, title: 'Farm Profile', onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfiledetailItem(
                    imageUrl: imageUrl,
                    farmName: farmName,
                    farmDescription: farmDescription,
                    firstLastName: firstLastName,
                    email: email,
                    phone: phone,
                    location: location,
                  ),
                ),
              );
            }, fontSize: 50),
          ],
        );
      },
    );
  }
}
