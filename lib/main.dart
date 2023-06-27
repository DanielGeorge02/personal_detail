import 'package:flutter/material.dart';
import 'package:flutter_application_1/MyHomePage.dart';
import 'package:flutter_application_1/services/edituser.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'adduser.dart';
import 'model/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
