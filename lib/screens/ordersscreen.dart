import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersScreen extends StatefulWidget {
  static const String screenroutes = 'OrdersScreen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final ordersCollection = FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 244, 149, 181),
        title: Row(
          children: [
            Image.asset(
              'assets/tractor.png',
              width: 45,
              height: 45,
            ),
            SizedBox(width: 5),
            Text('Place your Order'),
          ],
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ordersCollection.get(), // جلب جميع الطلبات من Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // إذا كانت البيانات قيد التحميل، يتم عرض مؤشر التحميل.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // إذا حدث خطأ، يتم عرض الخطأ.
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No orders available'), // إذا لم تكن هناك بيانات متاحة، يتم عرض رسالة بأنه لا توجد طلبات.
            );
          } else {
            // إذا تم جلب البيانات بنجاح، يتم عرضها في واجهة المستخدم.
            final orders = snapshot.data!.docs;

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final data = order.data() as Map<String, dynamic>;

                return Container(

                  child: ListTile(
                    title: Text('Order '),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product Name: ${data['name']}'),
                        //Text('Customer Name: ${data['firstName']} ${data['lastName']}'),
                        Text('Customer Email: ${data['email']}'),
                       // Text('Customer Phone: ${data['phone']}'),
                        Text('Customer Location: ${data['location']}'),
                      ],
                    ),
                    trailing: IconButton(onPressed: (){}, icon: Icon(Icons.check, color: Colors.green,)),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
