import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample_app/Components/constants.dart';
import 'package:firebase_sample_app/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _email = TextEditingController();


  Future<void> sendPasswordResetLink(TextEditingController email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
      // Navigate to HomePage on successful login and remove all previous pages
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false, // This will remove all previous routes
      );
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.message ?? "An unknown error occurred.");
    }
  }

   void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }


  
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 230, 204),
      body: Column(
       
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [

          Container(
           
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text("No Worries, We've Got You!!", style: GoogleFonts.ebGaramond(fontSize: 30, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 96, 25, 20)), textAlign: TextAlign.center, )),
            Image.asset('assets/images/gotyou.png'),
        Container(
            // width: size.width * 0.9,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 238, 214, 184),
              borderRadius: BorderRadius.circular(29),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextField(
              controller: _email,
              decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0), // Margin around the icon
                    child: Icon(
                      Icons.email,
                      color: kPrimaryColor,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                  hintText: "Enter your email",
                  hintStyle:
                      GoogleFonts.firaSansCondensed(color: kDarkBrownColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(29.0),
                      borderSide: BorderSide.none)),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          SizedBox(
            width: size.width * 0.4,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
              ),
              onPressed:(){
                sendPasswordResetLink(_email);
              },
              child: const Text(
                "SEND EMAIL",
                style: TextStyle(color: kBeigeColor),
              ),
            ),
          ),
            ],),
    );
  }
}