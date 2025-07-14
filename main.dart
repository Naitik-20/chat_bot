import 'package:flutter/material.dart';
import 'login.dart'; // Import your new login page file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'YourAppFont', // Optional: Use a consistent font
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(), // Set LoginPage as the home screen
    );
  }
}