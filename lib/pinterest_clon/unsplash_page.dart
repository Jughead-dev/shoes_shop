import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:translate/pinterest_clon/unsplash_api.dart';

class UnsplashPage extends StatefulWidget {
  const UnsplashPage({super.key});

  @override
  State<UnsplashPage> createState() => _UnsplashPageState();
}

class _UnsplashPageState extends State<UnsplashPage> {
  bool isLoading = false;
  List<dynamic> images = [];
  @override
  void initState() {
    super.initState();
    _getImageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.75,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    var image = images[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        fit: BoxFit.cover,
                        image['urls']['small'],
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error);
                        },
                      ),
                    );
                  },
                ),
      ),
    );
  }

  void _getImageList() {
    setState(() {
      isLoading = true;
    });
    UnsplashApi.GET(UnsplashApi.IMAGE_LIST, {
      'page': '3',
      'per_page': '30',
    }).then((response) async {
      if (response != null) {
        setState(() {
          images = List.from(jsonDecode(response));
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}
