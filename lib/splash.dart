import 'package:flutter/material.dart';
import 'package:project_universe/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'UNIverse')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE6), // Match the logo background color
      body: Center(
        child: Container(
          width: double.infinity,  // Make the image fill the width
          height: MediaQuery.of(context).size.height, // Make the image take up the full screen height
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain, // Maintain the aspect ratio, don't crop
          ),
        ),
      ),
    );
  }
}
