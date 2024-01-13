import 'package:flutter/material.dart';
import 'package:smart_home_app/home_screen.dart';


void main() => runApp(const Onboarding());

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}