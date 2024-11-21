import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 8, 82),  // Customize color for AppBar
        title: const Text('Login'),  // Optional title for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Welcome Text
            const Text(
              'Welcome to UNIverse!!',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 25, 2, 62),
                fontWeight: FontWeight.bold, // Optional: for bold text
              ),
            ),
            const SizedBox(height: 40),

            // Username TextField
            const TextField(
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Password TextField
           const TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 40),

            // Login Button
            ElevatedButton(
              onPressed: () {
                // You can add your login logic here (e.g., check credentials)
                // For now, it navigates to the home page after login
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
