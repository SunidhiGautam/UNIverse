import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    super.key, required this.child,
  });


  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          Positioned(
           top: 200,
           right: 10,
            child: Image.asset('assets/images/logincentre.png'),
          ),
          Positioned(
            bottom: -120,
            right: -90,
            child: Image.asset('assets/images/loginbottom.png'),
          ),
          Positioned(
              top: -100,
              left: -160,
              child: Image.asset('assets/images/logintop.png')),
              child,

        ],
      ),
    );
  }
}
