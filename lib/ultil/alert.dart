import 'package:flutter/material.dart';

alert(BuildContext context, String msg, {Function calback}) {
  showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          child: AlertDialog(
            title: Text("Carros"),
            content: Text(msg),
            actions: [
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  if(calback!=null){
                    calback();
                  }
                },
                child: Text("OK"),
              )
            ],
          ),
          onWillPop: null,
        );
      });
}
