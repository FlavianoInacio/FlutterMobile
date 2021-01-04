import 'package:flutter/material.dart';

class TextPage extends StatelessWidget {
  String labelText;
  String hintText;
  bool obscureText;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;

  TextPage(this.labelText, this.hintText,
      {this.obscureText = false,
      this.controller,
      this.validator,
      this.keyboardType,
      this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      textInputAction: textInputAction,
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: (TextStyle(fontSize: 16)),
          hintStyle: (TextStyle(fontSize: 13))),
    );
  }
}
