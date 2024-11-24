import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    required this.child,
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
    
      child: Stack(
        alignment: Alignment.center,
        children: <Widget> [
          Positioned(
          top: -160,
          left: -165,
          child: 
          Image.asset('assets/images/signuptop.png'),
          ),
    
          Positioned(
            bottom: -140,
            left: -140,
            child: Image.asset('assets/images/signupbottom.png'),),
    
    
            // Positioned(
            // top: 200,
            // child: Image.asset('assets/images/signup.png',
            // height: 300,)
            // ),
            child,
        ],
      ),
    );
  }
}


