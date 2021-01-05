

import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  Function onPressed;
  String texto;
  bool showProgress;
  Color buttonColor;
  TextStyle textButtonColor;
  ButtonPage(this.texto,{this.onPressed, this.showProgress = false,this.buttonColor,this.textButtonColor} );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: buttonColor==null?Colors.blue:buttonColor,
        onPressed: onPressed,
        child: Center(
          child: this.showProgress? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ): Text(
            texto,
            style: textButtonColor==null?TextStyle(color: Colors.white, fontSize: 22):textButtonColor,
          ),
        )
      ),
    );
  }
}
