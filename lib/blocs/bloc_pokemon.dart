import 'dart:async';

import 'package:flutter_pokemons/api/pokemon_api.dart';
import 'package:flutter_pokemons/blocs/bloc_simple.dart';
import 'package:flutter_pokemons/instancias/pokemon.dart';

class BlocPokemon extends BlocSimple<List<Pokemon>>{
  loadData(String tipo ) async {
    try {
      List<Pokemon> pokemons =  await  PokemonApi.getPokemons(tipo);
      add(pokemons);
    } catch (e) {
      addError(e);
    }
  }


}