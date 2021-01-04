import 'dart:async';

import 'package:flutter_pokemons/api/login_api.dart';
import 'package:flutter_pokemons/blocs/bloc_simple.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';
import 'package:flutter_pokemons/ultil/api_response.dart';

class BlocLogin extends BlocSimple<bool>{

  login(String login,String senha) async{
    try {
      add(true);
      //ApiResponse apiResponse = await LoginApi.login(login, senha);
      ApiResponse apiResponse = await FirebaseService().login(login, senha);
      add(false);
      return apiResponse;
    } catch (e) {
      addError(e);
    }
  }
}