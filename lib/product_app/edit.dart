import 'package:flutter/material.dart';

import 'product.dart';

class Edit extends StatelessWidget {
  final Product product;
  const Edit({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          "Edit contact",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, color: Colors.black),
          ),
          SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete, color: Colors.black),
          ),
        ],
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // CircleAvatar(
            //     radius: 50,
            //     backgroundImage: AssetImage(product.imagePath),
            //   ),
            SizedBox(height: 12),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nomi: ${product.name}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                "Narxi: ${product.price} so'm",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                "Tavsifi:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 6),
            Text(product.description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
