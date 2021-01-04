import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pokemons/blocs/bloc_pokemon.dart';
import 'package:flutter_pokemons/instancias/pokemon.dart';
import 'file:///C:/Users/flaviano.inacio/AndroidStudioProjects/flutter_pokemons/lib/pokemons/pokemon_listview.dart';

class PokemonPageView extends StatefulWidget {
  @override
  String tipo;

  PokemonPageView(this.tipo);

  @override
  _PokemonPageViewState createState() => _PokemonPageViewState();
}

class _PokemonPageViewState extends State<PokemonPageView> with AutomaticKeepAliveClientMixin<PokemonPageView> {
  //List<Pokemon> pokemons;
  final bloc = BlocPokemon();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.loadData(widget.tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
        stream: bloc.fetch,
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text(
                "Erro ao carregar os dados!"
              ),
            );
          }
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Pokemon> pokemons = snapshot.data;
          return PokemonListView(pokemons);

    });
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }


}
