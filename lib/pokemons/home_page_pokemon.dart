import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/api/carro_api.dart';
import 'package:flutter_pokemons/api/pokemon_api.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/instancias/pokemon.dart';
import 'package:flutter_pokemons/ultil/drawer_list.dart';
import 'package:flutter_pokemons/ultil/prefs.dart';
import 'file:///C:/Users/flaviano.inacio/AndroidStudioProjects/flutter_pokemons/lib/pokemons/pokemon_page_view.dart';

class HomePagePokemon extends StatefulWidget {
  @override
  _HomePagePokemonState createState() => _HomePagePokemonState();
}

class _HomePagePokemonState extends State<HomePagePokemon>
    with SingleTickerProviderStateMixin<HomePagePokemon> {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    Future<int> future = Prefs.getInt("tabidxp");
    future.then((int tabidxp) {
      _tabController.index = tabidxp;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabidxp", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemons"),
        bottom: TabBar(
          tabs: [
            Tab(
              text: "Normal",
            ),
            Tab(
              text: "Lutador",
            ),
            Tab(
              text: "Voador",
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: [
          PokemonPageView(TipoPokemon.normal),
          PokemonPageView(TipoPokemon.fighting),
          PokemonPageView(TipoPokemon.flying),
        ],
        controller: _tabController,
      ),
      drawer: DrawerPage(),
    );
  }
}
