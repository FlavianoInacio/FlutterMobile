import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';

import 'carro_listview.dart';

class CarrosSearch extends SearchDelegate {
  CollectionReference get _users =>
      FirebaseFirestore.instance.collection("users");
  get _carros => _users
      .doc(firebaseUserId)
      .collection("pokemons");
  Stream<QuerySnapshot> get stream => _carros.snapshots();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 2) {
      return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot) {
          if(snapshot.hasData){
            List<Carro> carros =
            snapshot.data.docs.map((DocumentSnapshot document) {
              return Carro.fromMap(document.data());
            }).toList();
            List<Carro> carrosSearch =[];
            for(Carro carro in carros){
              if(carro.nome.toUpperCase().contains(query.toUpperCase())){
                carrosSearch.add(carro);
              }
            }
            return CarroListView(carrosSearch);
          }
          else{
            return Center(
              child: CircularProgressIndicator(

              ),
            );
          }

        },
      );
    }
    return Container(

    );
  }
}
