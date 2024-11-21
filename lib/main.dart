import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project_universe/home.dart';
import 'package:project_universe/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),


      home: AnimatedSplashScreen(
        splash: Center(
          child: Image.asset(
            'assets/images/logo_new.png', // Path to your logo
            width: double.infinity, // Full width
            height: double.infinity, // Full height
            fit: BoxFit.contain, // Ensure proper scaling
          ),
        ),
        splashIconSize:
            double.infinity, // Makes sure the logo takes up the full space
        backgroundColor: const Color.fromARGB(
            255, 248, 237, 215), // Match the background color of your logo
        duration: 3000, // Duration for the splash screen to be visible
        splashTransition:
            SplashTransition.fadeTransition, // Fade transition effect
        nextScreen:
            const LoginPage(), // Next screen after splash
      ),


      routes: {
        '/home': (context) => const MyHomePage(title: 'UNIverse'), // Home screen route
        '/login': (context) => const LoginPage(),  // Login screen route
      },
      initialRoute: '/',


      
    );
  }
}
