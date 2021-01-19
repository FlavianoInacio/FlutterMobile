import 'dart:convert' as convert;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pokemons/api/upload_service.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/instancias/usuario.dart';
import 'package:flutter_pokemons/services/favorito_service.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';
import 'package:flutter_pokemons/ultil/api_response.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
  static final String Fogo = "Fogo";
  static final String Agua = "Agua";
  static final String Planta = "Planta";
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

  static Future<ApiResponse<bool>> saveFirebase(Carro c, File file) async{
    DocumentReference docRef;
    CollectionReference _users = FirebaseFirestore.instance.collection("users");
    CollectionReference _carros = _users.doc(firebaseUserId).collection(
        "pokemons");
    if(file!=null){
      String urlFotoDownload = await FirebaseService().uploadFirebaseFoto(file);
      c.urlFoto = urlFotoDownload;
    }
    if(c.idFirebase!=null){
      docRef = _carros.doc("${c.idFirebase}");
    }else{
      docRef = _carros.doc();
    }
    docRef.set(c.toMap()).then((value) {
      c.idFirebase = docRef.id;
      docRef.set(c.toMap());
    });
    return ApiResponse.ok(results: true);
  }
  static Future<ApiResponse<bool>> deleteFirebase(Carro c) async{
    DocumentReference docRef;
    CollectionReference _users = FirebaseFirestore.instance.collection("users");
    CollectionReference _carros = _users.doc(firebaseUserId).collection(
        "pokemons");

      docRef = _carros.doc("${c.idFirebase}");
      docRef.delete();
      return ApiResponse.ok(results: true);
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
