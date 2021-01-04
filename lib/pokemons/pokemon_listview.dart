

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/instancias/pokemon.dart';
import 'package:flutter_pokemons/pokemons/pokemon_page.dart';
import 'package:flutter_pokemons/ultil/nav.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PokemonListView extends StatelessWidget {
  List<Pokemon> pokemons;

  PokemonListView(this.pokemons);

  @override
  Widget build(BuildContext context) {
    return listview(pokemons,context);
  }
  Container listview(List<Pokemon> pokemons,BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: pokemons != null ? pokemons.length : 0,
          itemBuilder: (context, index) {
            Pokemon c = pokemons[index];
            return _card(c, context);
          }),
    );
  }
  Card _card(Pokemon c, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: c.urlfoto,
                width: 150,
              ),
            ),
            Text(
              c.nome,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Descrição...",
              style: TextStyle(fontSize: 14),
            ),
            ButtonBarTheme(
              data: ButtonBarTheme.of(context),
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('DETALHES'),
                    onPressed: () {
                      _onclickDetalhe(context,c);
                    },
                  ),
                  FlatButton(
                    child: const Text('SHARE'),
                    onPressed: () {
                      /* ... */
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _onclickDetalhe(BuildContext context,Pokemon pokemon) {
    navigator(context, PokemonPage(pokemon));
  }
}
