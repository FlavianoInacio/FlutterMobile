import 'package:flutter_pokemons/blocs/bloc_simple.dart';
import 'package:flutter_pokemons/database/carro_dao.dart';
import 'package:flutter_pokemons/database/favorito_dao.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/instancias/favorito.dart';
import 'package:flutter_pokemons/services/favorito_service.dart';

class BlocFavorito extends BlocSimple<List<Carro>>{

  loadData() async {
    try {
      List<Carro> carros = await FavoritoService.getCarros();
      print(carros);
      add(carros);
      return carros;
    } catch (e) {
      print(e);
      addError(e);
    }
  }

}