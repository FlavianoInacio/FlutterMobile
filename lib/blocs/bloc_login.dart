import 'dart:async';

import 'package:flutter_pokemons/blocs/bloc_simple.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';
import 'package:flutter_pokemons/ultil/api_response.dart';

class BlocLogin extends BlocSimple<bool>{

  login(String login,String senha) async{
    try {
      add(true);
      //ApiResponse apiResponse = await LoginApi.login(login, senha);
      ApiResponse apiResponse = await FirebaseService().login(login, senha);
      Future.delayed(const Duration(seconds: 3), () {
        add(false);
      }
      );
      return apiResponse;
    } catch (e) {
      addError(e);
    }
  }
}