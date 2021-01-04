import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/api/carro_api.dart';
import 'package:flutter_pokemons/carros/carro_form_page.dart';
import 'package:flutter_pokemons/favoritos/favorito_page_view.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/ultil/drawer_list.dart';
import 'package:flutter_pokemons/ultil/nav.dart';
import 'package:flutter_pokemons/ultil/prefs.dart';
import 'file:///C:/Users/flaviano.inacio/AndroidStudioProjects/flutter_pokemons/lib/carros/carro_page_view.dart';

class HomePageCarro extends StatefulWidget {
  @override
  _HomePageCarroState createState() => _HomePageCarroState();
}

class _HomePageCarroState extends State<HomePageCarro>
    with SingleTickerProviderStateMixin<HomePageCarro> {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 4, vsync: this);
    Future<int> future = Prefs.getInt("tabidx");

    future.then((int tabidx){
      _tabController.index = tabidx;
      print(tabidx);
    });

    _tabController.addListener(() {
        Prefs.setInt("tabidx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: "Clássicos",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Esportivos",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Luxo",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Favoritos",
              icon: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          CarroPageView(TipoCarro.classicos),
          CarroPageView(TipoCarro.esportivos),
          CarroPageView(TipoCarro.luxo),
          FavoritoPageView(),
        ],
        controller: _tabController,
      ),
      drawer: DrawerPage(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onClickAdd,
      ),
    );
  }

  void onClickAdd() {
    navigator(context, CarroFormPage());
  }
}
