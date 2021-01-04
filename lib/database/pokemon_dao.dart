import 'package:flutter_pokemons/database/base_dao.dart';
import 'package:flutter_pokemons/instancias/pokemon.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'db_helper_pokemon.dart';

class PokemonDao extends BaseDao<Pokemon>{
  @override
  Pokemon fromJson(Map<String, dynamic> map) {
    return Pokemon.fromMap(map);
  }

  @override
  // TODO: implement tableName
  String get tableName => 'pokemon';

  @override
  // TODO: implement db
  Future<Database> get db => DatabaseHelperPokemon.getInstance().db;

}