import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universeproject/Components/constants.dart';
import 'package:universeproject/Screens/Login/login_screen.dart';
import 'package:universeproject/Screens/SignUp/signup_screen.dart';
import 'package:universeproject/Screens/Welcome/background.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 450,
              child: Text(
                "Welcome to",
                style: GoogleFonts.vollkorn(
                  fontSize: 30,
                  color: kDarkBrownColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Login Button
            Container(
              width: size.width * 0.6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }),
                    );
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            // Signup Button
            Container(
              width: size.width * 0.6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 234, 212),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const SignupScreen();
                      }),
                    );
                    // Navigation logic
                  },
                  child: const Text(
                    "SIGN IN",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
