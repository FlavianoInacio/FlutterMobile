import 'dart:convert';

import 'package:flutter_pokemons/database/pokemon_dao.dart';
import 'package:flutter_pokemons/instancias/pokemon.dart';
import 'package:http/http.dart' as http;

class TipoPokemon{
  static final String normal = "normal";
  static final String fighting = "fighting";
  static final String flying = "flying";
}
class PokemonApi {
  static Future<List<Pokemon>> getPokemons(String tipo) async {
  try{
    var url = 'https://pokeapi.co/api/v2/type/$tipo';
    print(url);
    var response = await http.get(url);
    Map mapResponse = json.decode(response.body);
    final List<Pokemon> pokemons = List<Pokemon>();
    for(Map map in mapResponse["pokemon"]){
      Pokemon pokemon = Pokemon.fromMap(map["pokemon"]);
      var urldetalhe = pokemon.urldetalhe;
      var responsedetalhe = await http.get(urldetalhe);
      Map mapResponseDetalhe = json.decode(responsedetalhe.body);
      pokemon.urlfotodetalhe=mapResponseDetalhe["sprites"]["other"]["official-artwork"]["front_default"];
      pokemon.urlfoto=mapResponseDetalhe["sprites"]["other"]["dream_world"]["front_default"];
      pokemon.id = mapResponseDetalhe["id"];
      for(Map map in mapResponseDetalhe["types"]){
        pokemon.add(map['type']['name']);
      }
     // print(pokemon);
      final dao = PokemonDao();
      for(Pokemon p in pokemons){
        dao.save(p);
      };
      pokemons.add(pokemon);
    }
    return pokemons;
  }
  catch(error){
      print(error);
  }

  }
}
