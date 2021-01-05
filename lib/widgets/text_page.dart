import 'package:flutter/material.dart';

class TextPage extends StatelessWidget {
  String labelText;
  String hintText;
  bool obscureText;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  TextStyle textStyle;
  TextStyle labelStyle;
  TextStyle hintStyle;

  TextPage(this.labelText, this.hintText,
      {this.obscureText = false,
      this.controller,
      this.validator,
      this.keyboardType,
      this.textInputAction,
      this.textStyle,
      this.labelStyle,
      this.hintStyle});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      textInputAction: textInputAction,
      style: textStyle==null?TextStyle(color: Colors.blue):textStyle,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: labelStyle==null?(TextStyle(fontSize: 16)):labelStyle,
          hintStyle: hintStyle==null?(TextStyle(fontSize: 13)):hintStyle),
    );
  }
}
