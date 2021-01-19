import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/ultil/nav.dart';
import 'package:share/share.dart';

import 'carro_page.dart';

class CarroListView extends StatelessWidget {
  List<Carro> carros;

  CarroListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return listview(context, carros);
  }

  Container listview(BuildContext context, List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: carros != null ? carros.length : 0,
          itemBuilder: (context, index) {
            Carro c = carros[index];
            return Container(
              child: InkWell(
                onTap: (){
                  _onclickDetalhes(context, c);
                },
                onLongPress:(){
                  _onLongClickCarro(context,c);
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: c.urlFoto != null
                                ? Image.network(c.urlFoto)
                                : Image.asset(
                                    "assets/images/naoencontrada.png",
                                    height: 150,
                                  )),
                        Text(
                          c.nome ?? "Teste",
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
                                  _onclickDetalhes(context, c);
                                },
                              ),
                              FlatButton(
                                child: const Text('SHARE'),
                                onPressed: () {
                                  _onclickShare(context,c);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _onclickDetalhes(BuildContext context, Carro c) {
    navigator(context, CarroPage(c));
  }

  _onLongClickCarro(BuildContext context, Carro c) {
    showModalBottomSheet(context: context, builder: (context){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(c.nome,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
          ),
          ListTile(
            title: Text("Detalhes"),
            onTap: () {
              Navigator.pop(context);
              _onclickDetalhes(context, c);
            },
            trailing: Icon(Icons.adb),
          ),
          ListTile(
            title: Text("Share"),
            onTap: (){
              _onclickShare(context,c);
            },
            trailing: Icon(Icons.share),
          ),
        ],
      );
    });
    
  }

  void _onclickShare(BuildContext context, Carro c) {
    Share.share(c.urlFoto);
  }
}
