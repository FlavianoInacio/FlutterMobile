import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/carros/home_page_carro.dart';
import 'package:flutter_pokemons/database/db_helper.dart';
import 'package:flutter_pokemons/login_page.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';
import 'package:flutter_pokemons/ultil/firebase.dart';
import 'package:flutter_pokemons/ultil/nav.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {

    initFcm();

    User userlogado = FirebaseAuth.instance.currentUser;
    Future futureA = DatabaseHelper.getInstance().db;
    Future futureB = Future.delayed(Duration(seconds: 3));
    Future.wait([futureA,futureB]).then((List values){
      User user = userlogado;
      if(user!=null){
        firebaseUserId = user.uid;
      }
      if(user!=null){
        navigator(context, HomePageCarro(),replace: true);
      }
      else{
        navigator(context,LoginPage(),replace: true);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, child: Center(child: CircularProgressIndicator(
      backgroundColor: Colors.white,
    ),),);
  }
}