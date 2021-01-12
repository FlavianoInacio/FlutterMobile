import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/services/favorito_service.dart';
import 'file:///C:/Users/flaviano.inacio/AndroidStudioProjects/flutter_pokemons/lib/carros/carro_listview.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';

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

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<QuerySnapshot>(
        stream: FavoritoService().stream,
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
          List<Carro> carros = snapshot.data.docs.map((DocumentSnapshot document){
            return Carro.fromMap(document.data());
          }).toList();
          return  CarroListView(carros);
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
