import 'package:flutter/material.dart';
import 'package:universeproject/Screens/Welcome/body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(), // Use Scaffold to provide default safe layout
    );
  }
}
