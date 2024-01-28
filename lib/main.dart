import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Upgrade Example'),
      ),
      body: Center(
        child: TextButton(
          child: Text('Check for Updates'),
          onPressed: () {
            showUpdateDialog(context);
          },
        ),
      ),
    );
  }

  void showUpdateDialog(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    String newVersion = '1.0.35';
    final dialogResult = await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('هل تريد تحديث التطبيق'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text( ' نسخة جديدة من كلامي متوفرة\n النسخة الحالية هي :$currentVersion '),
            SizedBox(height: 10),
            Text(
              ' النسخة الجديدة :   $newVersion', // Replace with your new version
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(': ما الجديد في هذه النسخة'),
            SizedBox(height: 5),
            Text(
              'تم إضافة خاصية الإشعارات',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              'تحسين واجهة المستخدم ',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('لاحقا'),
            onPressed: () => Navigator.pop(context, false),
          ),
          CupertinoDialogAction(
            child: Text('حدث الآن'),
            onPressed: () {
              String appUrl = 'https://play.google.com/store/apps/details?id=com.cptit.tal3thoom';
              launch(appUrl);
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );

    if (dialogResult == true) {
      // Handle upgrade logic
      // You can navigate to the app store or perform other actions
      // to prompt the user to upgrade the app
    }
  }
}