import 'package:flutter/material.dart';
import 'package:translate/product_app/product.dart';
import 'package:translate/product_app/product_item.dart';

import 'create_page.dart';
import 'edit.dart';
import 'home.dart';

const List<String> productImages = [
  "assets/images/shoes.webp",
  "assets/images/shoes1.webp",
  "assets/images/shoes2.webp",
  "assets/images/shoes3.webp",
  "assets/images/shoes4.webp",
  "assets/images/shoes5.webp",
  "assets/images/shoes6.webp",
  "assets/images/shoes7.webp",
  "assets/images/shoes8.webp",
  "assets/images/shoes9.webp",
  "assets/images/shoes10.webp",
  "assets/images/shoes11.webp",
  "assets/images/shoes12.webp",
  "assets/images/shoes13.webp",
  "assets/images/shoes14.webp",
  "assets/images/shoes15.webp",
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<Product> products = [];
  bool isLoading = false;
  bool isFloating = false;
  Map<int, bool> isDeleting = {};
  @override
  void initState() {
    super.initState();
    _getProductList();
    _apiProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 216, 214, 214),
        title: Text("mobisport", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Running",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 172),
                Text(
                  "${products.length} results",

                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder:
                        (context, index) => MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => Edit(product: products[index]),
                              ),
                            );
                          },
                          onLongPress: () {
                            deleteProduct(products[index]);
                          },
                          child: ProductItem(
                            product: products[index],
                            imagepath:
                                index < productImages.length
                                    ? productImages[index]
                                    : "assets/images/defaultImage.webp",
                            isDeleting: isDeleting[products[index].id] ?? false,
                            onDelete: () {
                              setState(() {
                                isDeleting[products[index].id] = true;
                              });
                              deleteProduct(products[index]);
                            },
                          ),
                        ),
                  ),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isFloating = true;
          });

          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePage()),
          ).then((value) {
            if (value == true) {
              _apiProductList();
            }
          });
          setState(() {
            isFloating = false;
          });
        },
        child:
            isFloating
                ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                : Icon(Icons.add),
      ),
    );
  }

  void _getProductList() async {
    setState(() {
      isLoading = true;
    });
    final response = await Home.GET(Home.PRODUCT_LIST, Home.paramsEmpty());

    if (response != null) {
      setState(() {
        isLoading = false;
        products = Home.parsePostList(response);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void deleteProduct(Product product) async {
    await Home.DELETE(
      Home.POST_DELETE + product.id.toString(),
      Home.paramsEmpty(),
    );
    setState(() {
      isDeleting.remove(product.id);
    });
    _getProductList();
  }

  void _createProduct(Product product) {
    Home.POST(Home.PRODUCT_CREATE, Home.paramsCreate(product)).then((response) {
      print(response);
      _getProductList();
    });
  }

  void _apiProductList() async {
    var response = await Home.GET(Home.PRODUCT_LIST, Home.paramsEmpty());
    if (response != null) {
      setState(() {
        products = Home.parsePostList(response);
      });
    }
  }
}
