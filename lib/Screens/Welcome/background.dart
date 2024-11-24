import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Main background image
          Positioned(
            bottom: 60,
            child: Image.asset(
              'assets/images/welcome.png',
              width: size.width * 0.9,
              height: size.height * 0.8,
            ),
          ),
          // Top decorative image
          Positioned(
            top: -100, // Adjusted to avoid negative positioning
            left: -120,
            child: Image.asset(
              'assets/images/welcometop.png',
              width: size.width * 0.8,
            ),
          ),
          // Bottom decorative image
          Positioned(
            bottom: -100, // Adjusted to avoid negative positioning
            left: -140,
            child: Image.asset(
              'assets/images/welcomebottom.png',
              width: size.width * 0.8,
            ),
          ),

          Positioned(
            top: 140,
            child: Image.asset(
              'assets/images/text.png',
              height: size.height * 0.30,
              width: size.width * 0.8,
            ),),
          // Main content
          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}
