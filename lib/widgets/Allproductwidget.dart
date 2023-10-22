import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';



class ProductItem2 extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final int productPrice;

  ProductItem2({
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
        child: Container(
          width: 100,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: Colors.black.withOpacity(0.7), // لون الصورة السوداء شفاف
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover, // جعل الصورة تغطي الحاوية بالكامل
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end, // لجعل النصوص تظهر في الجزء السفلي من الحاوية
            children: [
              Container(
                color: Colors.black.withOpacity(0.7), // لون الشريط
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        productName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        '\$$productPrice',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}





