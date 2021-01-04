import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter_pokemons/api/upload_service.dart';
import 'package:flutter_pokemons/database/carro_dao.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/instancias/usuario.dart';
import 'package:flutter_pokemons/ultil/api_response.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}
class CarroApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    var url = 'http://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';

    var response = await http.get(url);

    List mapResponse = convert.json.decode(response.body);

    final List<Carro> carros = List<Carro>();
    for(Map map in mapResponse){
      carros.add(Carro.fromMap(map));
    }
    return carros;

  }

  static Future<ApiResponse<bool>> save(Carro c, File file) async{
    if(file!=null){
      ApiResponse apiResponse = await UploadService.upload(file);
      if(apiResponse.ok){
        String urlFoto = apiResponse.results;
        c.urlFoto = urlFoto;
      }
    }
    Usuario user = await Usuario.get();
    Map<String,String> headers = {
      "Content-Type":"application/json",
      "Authorization": "Bearer ${user.token}"
    };
    var url = "http://carros-springboot.herokuapp.com/api/v2/carros";

    if(c.id!=null){
      url += "/${c.id}";
    }
    String json = c.toJson();

    var response = await (c.id == null?
    http.post(url,body: json,headers: headers):
    http.put(url,body: json,headers: headers)
    );

    print("status:${response.statusCode}");
    print("body:${response.body}");

    if(response.statusCode== 201 || response.statusCode== 200 ){
      Map mapResponse = convert.json.decode(response.body);

      Carro carro = Carro.fromMap(mapResponse);
      print(carro);
      return ApiResponse.ok(results: true);
    }
    Map mapResponse = convert.json.decode(response.body);
    return ApiResponse.error(mapResponse["error"]);
  }

  static Future<ApiResponse<bool>> deletar(Carro c) async {
    Usuario user = await Usuario.get();
    Map<String,String> headers = {
      "Content-Type":"application/json",
      "Authorization": "Bearer ${user.token}"
    };
    var url = "http://carros-springboot.herokuapp.com/api/v2/carros/${c.id}";


    var response = await http.delete(url,headers: headers);

    print("status:${response.statusCode}");
    print("body:${response.body}");

    if(response.statusCode== 200 ){
      return ApiResponse.ok(results: true);
    }
    Map mapResponse = convert.json.decode(response.body);
    return ApiResponse.error(mapResponse["error"]);
  }
}
