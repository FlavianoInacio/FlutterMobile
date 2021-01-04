import 'dart:convert';

import 'package:flutter_pokemons/instancias/usuario.dart';
import 'package:flutter_pokemons/ultil/api_response.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse> login(String login, String senha) async {
    try {
    var url = 'http://carros-springboot.herokuapp.com/api/v2/login';
    Map<String, String> headers = {
      "Content-Type": "application/json"
    };
    Map maps = {
      "username": login,
      "password": senha
    };
    String params = json.encode(maps);
      var response = await http.post(url, body: params, headers: headers);
      Map mapResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final Usuario user = Usuario.fromJson(mapResponse);
        user.save();
        Usuario user2 = await Usuario.get();
        print("user 2" + user2.toString());

        return ApiResponse.ok(results: user);
      }
      else {
        return ApiResponse.error(mapResponse["error"]);
      }
    }
    catch (error) {
      return ApiResponse.error("Não foi possível efetuar o Login, tente novamente mais tarde!");

    }
  }
}
