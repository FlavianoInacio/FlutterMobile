

import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  Function onPressed;
  String texto;
  bool showProgress;
  ButtonPage(this.texto,{this.onPressed, this.showProgress = false} );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: Colors.blue,
        onPressed: onPressed,
        child: Center(
          child: this.showProgress? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ): Text(
            texto,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        )
      ),
    );
  }
}
