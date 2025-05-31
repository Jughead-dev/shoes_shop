import 'package:flutter/material.dart';
import 'package:translate/homework/nerwork1.dart';

class Task1 extends StatefulWidget {
  const Task1({super.key});

  @override
  State<Task1> createState() => _Task1State();
}

class _Task1State extends State<Task1> {
  @override
  void initState() {
    super.initState();
    _getPostsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Center(child: Text("Task1")));
  }

  void _getPostsList() {
    Network1.GET(Network1.POST_LIST, Network1.paramsEmpty()).then((response) {
      print(response);
    });
  }
}
