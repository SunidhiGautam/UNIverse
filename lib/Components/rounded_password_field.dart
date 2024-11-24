import 'package:flutter/material.dart';
import 'package:universeproject/Components/constants.dart';
import 'package:universeproject/Components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    super.key, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(child: TextField(
      obscureText: true,
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText : "Enter Your Password",
        hintStyle: TextStyle(color: Color.fromARGB(193, 85, 39, 1)),
        icon: Icon(Icons.lock, color: kPrimaryColor,),
        suffixIcon: Icon(Icons.visibility , color: kPrimaryColor,),
        border: InputBorder.none,
        
      ),
    ));
  }
}

