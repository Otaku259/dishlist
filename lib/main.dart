// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const DishList());
}

class DishList extends StatelessWidget {
  const DishList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DishList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const HomeScreen(),
    );
  }
}
