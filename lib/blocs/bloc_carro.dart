import 'dart:async';

import 'package:flutter_pokemons/api/carro_api.dart';
import 'package:flutter_pokemons/blocs/bloc_simple.dart';
import 'package:flutter_pokemons/database/carro_dao.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/ultil/newtwork.dart';

class BlocCarro extends BlocSimple<List<Carro>>{
  loadData(String tipo) async {
    try {
      bool netWork =  await netWorkOn();
      if(!netWork){
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }
      List<Carro> carros = await CarroApi.getCarros(tipo);
      final dao = CarroDAO();
      for(Carro c in carros){
        dao.save(c);
      }
      add(carros);
      return carros;
    } catch (e) {
      print(e);
      addError(e);
    }
  }
}