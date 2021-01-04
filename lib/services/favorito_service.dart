import 'package:flutter_pokemons/blocs/bloc_favorito.dart';
import 'package:flutter_pokemons/database/carro_dao.dart';
import 'package:flutter_pokemons/database/favorito_dao.dart';
import 'package:provider/provider.dart';
import '../instancias/carro.dart';
import '../instancias/favorito.dart';

class FavoritoService{

  static Future<bool> favoritar(Carro c, context) async{

    Favorito f = Favorito.fromCarro(c);
    FavoritoDao dao = FavoritoDao();
    bool exists = await dao.exists(c.id);
    if(!exists){
      dao.save(f);
      BlocFavorito bloc = Provider.of<BlocFavorito>(context,listen: false);
      bloc.loadData();
      return false;
    }
    else{
      dao.delete(c.id);
      BlocFavorito bloc = Provider.of<BlocFavorito>(context,listen: false);
      bloc.loadData();
      return true;
    }

  }
  static Future<List<Carro>> getCarros(){
    return CarroDAO().query("select * from carro,favorito where carro.id = favorito.id");
  }

  static Future<bool> getCarroFavorito(Carro c) async{
    FavoritoDao dao = FavoritoDao();
    bool exists = await dao.exists(c.id);
    return exists;
  }
}