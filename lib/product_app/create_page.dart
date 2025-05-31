import 'package:flutter/material.dart';
import 'package:translate/product_app/home.dart';
import 'product.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.blueGrey[800]),
        ),
        title: Text(
          "Add new contact",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check, color: Colors.blueGrey[800]),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/defaultImage.webp",
                width: 430,
                height: 122,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 52),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: "Shoes Name",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                keyboardType: TextInputType.number,
                controller: priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: "Price",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: "Descriptions",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              isSaving ? CircularProgressIndicator() : SizedBox(height: 142),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      setState(() {
                        isSaving = true;
                      });
                      final newProduct = Product(
                        id: 0,
                        name: nameController.text.trim(),
                        price: priceController.text.trim(),
                        description: descController.text.trim(),
                      );
                      final response = await Home.POST(
                        Home.PRODUCT_CREATE,
                        Home.paramsCreate(newProduct),
                      );
                      setState(() {
                        isSaving = false;
                      });
                      if (response != null) {
                        Navigator.pop(
                          context,
                          true,
                        ); // true bilan qaytsin, HomePage refresh qilishi uchun
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to create product")),
                        );
                      }
                    },
                    child: Container(
                      height: 58,
                      width: 178,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.amber,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Save", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
