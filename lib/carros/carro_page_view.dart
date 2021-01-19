import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/blocs/bloc_carro.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';

import 'carro_listview.dart';

class CarroPageView extends StatefulWidget {
  @override
  String tipoCarro;

  CarroPageView(this.tipoCarro);

  @override
  _CarroPageViewState createState() => _CarroPageViewState();
}

class _CarroPageViewState extends State<CarroPageView>
    with AutomaticKeepAliveClientMixin<CarroPageView> {
  CollectionReference get _users =>
      FirebaseFirestore.instance.collection("users");

  get _carros => _users
      .doc(firebaseUserId)
      .collection("pokemons")
      .where('tipo', isEqualTo: widget.tipoCarro).orderBy("id", descending: false);

  Stream<QuerySnapshot> get stream => _carros.snapshots();

  final bloc = BlocCarro();

  StreamSubscription<String> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<QuerySnapshot>(
        stream: stream,
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
          if(!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return Center(
              child: Text("Não existe nenhum registro!",style: TextStyle(fontSize: 18,color: Colors.blue,fontWeight: FontWeight.bold),),
            );
          }
          List<Carro> carros =
              snapshot.data.docs.map((DocumentSnapshot document) {
            return Carro.fromMap(document.data());
          }).toList();
          return CarroListView(carros);
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
    subscription.cancel();
  }
}
