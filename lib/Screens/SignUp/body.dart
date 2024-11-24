import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universeproject/Components/constants.dart';
import 'package:universeproject/Components/rounded_input_field.dart';
import 'package:universeproject/Components/rounded_password_field.dart';
import 'package:universeproject/Screens/Login/login_successful.dart';
import 'package:universeproject/Screens/SignUp/background.dart';


class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'SIGN UP',
            style: GoogleFonts.notoSerif(
                fontSize: 20,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold),
          ),
          Image.asset(
            'assets/images/signup.png',
            height: size.height * 0.35,
          ),
          RoundedInputField(
            hintText: "Name",
            onChanges: (value) => {},
          ),
          RoundedInputField(
            hintText: "College",
            onChanges: (value) => {},
          ),
          RoundedInputField(
            hintText: "Year",
            onChanges: (value) => {},
          ),
          RoundedInputField(
            hintText: "Branch",
            onChanges: (value) => {},
          ),
          RoundedInputField(
            hintText: "Email",
            onChanges: (value) => {},
          ),
          RoundedPasswordField(
            onChanged: (value) => {},
          ),
          Container(
            width : size.width * 0.4,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
              ),
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context){return LoginSuccessful();}),);
              },
              child: const Text(
                "SIGN UP",
                style: TextStyle(color: kBeigeColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
