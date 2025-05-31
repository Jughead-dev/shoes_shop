import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Translate extends StatefulWidget {
  const Translate({super.key});

  @override
  State<Translate> createState() => _TranslateState();
}

class _TranslateState extends State<Translate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "Translate",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Text('str_language'.tr()),
          MaterialButton(
            onPressed: () {
              context.setLocale(Locale('uz', 'UZ'));
            },
            child: Text("str_uzbek".tr()),
          ),
          MaterialButton(
            onPressed: () {
              context.setLocale(Locale('en', 'US'));
            },
            child: Text("str_english".tr()),
          ),
          MaterialButton(
            onPressed: () {
              context.setLocale(Locale('ru', 'RU'));
            },
            child: Text("str_russian".tr()),
          ),
          MaterialButton(
            onPressed: () {
              context.setLocale(Locale('kor', 'KOR'));
            },
            child: Text("str_korean".tr()),
          ),
          MaterialButton(
            onPressed: () {
              context.setLocale(Locale('nem', 'NEM'));
            },
            child: Text("str_german".tr()),
          ),
        ],
      ),
    );
  }
}
