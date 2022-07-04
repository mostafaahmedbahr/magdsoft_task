import 'package:flutter/material.dart';
class TextFormFieldCon extends StatelessWidget {
  final  emailCon;
  final String hintText;
  final IconData iconData;
  bool? isVisible;

    TextFormFieldCon({Key? key,
    required this.emailCon,
    required this.hintText,
    required this.iconData,
    this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isVisible!,
      controller: emailCon,
      validator: (value) {
        if (value!.isEmpty) {
          return "please enter your email";
        }
      },
      decoration: InputDecoration(
        fillColor: Colors.grey[300],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
        prefixIcon: Icon(iconData),
      ),
    );
  }
}
