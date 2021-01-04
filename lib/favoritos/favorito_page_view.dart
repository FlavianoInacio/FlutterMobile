import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pokemons/blocs/bloc_carro.dart';
import 'package:flutter_pokemons/blocs/bloc_favorito.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'file:///C:/Users/flaviano.inacio/AndroidStudioProjects/flutter_pokemons/lib/carros/carro_listview.dart';
import 'package:provider/provider.dart';

class FavoritoPageView extends StatefulWidget {

  @override
  _FavoritoPageViewState createState() => _FavoritoPageViewState();
}

class _FavoritoPageViewState extends State<FavoritoPageView>
    with AutomaticKeepAliveClientMixin<FavoritoPageView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocFavorito bloc = Provider.of<BlocFavorito>(context,listen: false);
    bloc.loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    BlocFavorito bloc = Provider.of<BlocFavorito>(context,listen: false);
    return StreamBuilder(
        stream: bloc.fetch,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Não foi possível exibir os dados"),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Carro> carros = snapshot.data;
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: CarroListView(carros),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  Future<void> _onRefresh() {
    BlocFavorito bloc = Provider.of<BlocFavorito>(context,listen: false);
    return bloc.loadData();
  }
}
