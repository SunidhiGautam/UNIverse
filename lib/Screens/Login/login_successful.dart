import 'dart:async';
import 'package:flutter/material.dart';
import 'package:universeproject/Components/constants.dart';
import 'package:universeproject/Screens/Welcome/welcome_screen.dart';


class LoginSuccessful extends StatefulWidget {

  const LoginSuccessful({super.key});

  @override
  State<LoginSuccessful> createState() => _LoginSuccessfulState();
}

class _LoginSuccessfulState extends State<LoginSuccessful> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const WelcomeScreen(),));
    });

  }
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      color: kBeigeColor,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
            Image.asset(
              'assets/images/loginsuccess.png',
            ),
            
           
          ],
        ),
    );
  }
}