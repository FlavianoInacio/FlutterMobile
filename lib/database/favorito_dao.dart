import 'package:flutter_pokemons/database/base_dao.dart';
import 'package:flutter_pokemons/instancias/favorito.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'db_helper.dart';

class FavoritoDao extends BaseDao<Favorito>{
  @override
  // TODO: implement db
  Future<Database> get db => DatabaseHelper.getInstance().db;

  @override
   fromJson(Map<String, dynamic> map) {
   return Favorito.fromMap(map);
  }

  @override
  // TODO: implement tableName
  String get tableName => "favorito";

}