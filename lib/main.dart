import 'package:flutter/material.dart';

import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee management system',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Google-inter',
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
