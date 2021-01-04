import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../instancias/pokemon.dart';

class PokemonPage extends StatelessWidget {
  Pokemon pokemon;

  PokemonPage(this.pokemon);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.nome),
        actions: [
          IconButton(icon: Icon(Icons.place), onPressed: _onclickMapa),
          IconButton(icon: Icon(Icons.videocam), onPressed: _onclickVideo),
          PopupMenuButton(
              onSelected: _onclickMenuButton,
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Editar"),
                    value: "Editar",
                  )
                ];
              }),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
   child: ListView(
     children: [
       Image.network(pokemon.urlfotodetalhe),
       bloco01(),
       Divider(),
       bloco02()
     ],
   ),
    );
  }

  Row bloco01() {
    return Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(pokemon.nome,style: TextStyle(fontWeight: FontWeight.bold),),
             for(var item in pokemon.tipos ) Text(item)
           ],
         ),
         Row(
           children: [
             IconButton(icon: Icon(Icons.favorite), onPressed: _onclickFavorite),
             IconButton(icon: Icon(Icons.share), onPressed: _onclickShare)
           ],
         )
       ],
     );
  }
  void _onclickMapa() {}

  void _onclickVideo() {}

  _onclickMenuButton(value) {
    print(value);
  }

  void _onclickFavorite() {
  }

  void _onclickShare() {
  }

  bloco02() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Descricao",style: TextStyle(fontSize: 16),),
        SizedBox(height: 15,),
        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
      ],
    );
  }
}
