import 'package:flutter/material.dart';
import 'package:universeproject/Components/constants.dart';
import 'package:universeproject/Components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanges;
  const RoundedInputField({
    super.key, required this.hintText,  this.icon = Icons.email, required this.onChanges,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(child: TextField(
      onChanged: onChanges,
      decoration: InputDecoration(
        icon: const Icon(Icons.email, color: kPrimaryColor,),
        hintText: hintText,
        hintStyle:const TextStyle(color: Color.fromARGB(193, 85, 39, 1)),
        border: InputBorder.none)
      ),
     );
  }
}

