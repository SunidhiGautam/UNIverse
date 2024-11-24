import 'dart:async';
import 'package:flutter/material.dart';
import 'package:universeproject/Components/constants.dart';
import 'package:universeproject/Screens/Welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> WelcomeScreen(),));
    });

  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Center(
        child: Container(
          height:double.infinity,
          color: kBeigeColor,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}