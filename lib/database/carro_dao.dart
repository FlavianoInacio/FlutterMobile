
import 'package:flutter_pokemons/database/base_dao.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'db_helper.dart';

// Data Access Object
class CarroDAO extends BaseDao<Carro> {
  @override
  // TODO: implement tableName
  String get tableName =>"carro";

  @override
  fromJson(Map<String, dynamic > map) {
    return Carro.fromMap(map);
  }

  @override
  // TODO: implement db
  Future<Database> get db => DatabaseHelper.getInstance().db;
}
