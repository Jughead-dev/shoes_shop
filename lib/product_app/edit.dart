import 'package:flutter/material.dart';

import 'product.dart';

class Edit extends StatelessWidget {
  final Product product;
  const Edit({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mahsulot tafsilotlari"),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(product.imagePath),
              ),
              SizedBox(height: 12),
            Text(
              "Nomi: ${product.name}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text("Narxi: ${product.price} so'm", style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text(
              "Tavsifi:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6),
            Text(product.description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
