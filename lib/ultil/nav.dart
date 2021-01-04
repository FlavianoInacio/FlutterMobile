import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

navigator(BuildContext context, Widget page, {replace=false}){
    if(replace){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return page;
      }));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return page;
      }));
    }

}