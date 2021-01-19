import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/api/carro_api.dart';
import 'package:flutter_pokemons/carros/carro_form_page.dart';
import 'package:flutter_pokemons/carros/mapa_page.dart';
import 'package:flutter_pokemons/carros/video_page.dart';
import 'package:flutter_pokemons/carros/youtube_page.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/services/favorito_service.dart';
import 'package:flutter_pokemons/ultil/alert.dart';
import 'package:flutter_pokemons/ultil/api_response.dart';
import 'package:flutter_pokemons/ultil/event_bus.dart';
import 'package:flutter_pokemons/ultil/nav.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  Color color = Colors.grey;

  @override
  void initState() {
    FavoritoService().getCarroFavorito(widget.carro).then((favorito) {
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: [
          IconButton(icon: Icon(Icons.place), onPressed: (){
            _onclickMapa(widget.carro);
          }),
          IconButton(icon: Icon(Icons.videocam), onPressed: (){
            _onclickVideo(widget.carro);
          }),
          PopupMenuButton(
              onSelected: _onclickMenuButton,
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Editar"),
                    value: "Editar",
                  ),
                  PopupMenuItem(
                    child: Text("Deletar"),
                    value: "Deletar",
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
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            widget.carro.urlFoto != null
                ? Image.network(widget.carro.urlFoto)
                : Image.asset(
                    "assets/images/naoencontrada.png",
                    height: 150,
                  ),
            bloco1(),
            Divider(),
            bloco2()
          ],
        ),
      ),
    );
  }

  Row bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.carro.nome,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.carro.tipo)
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: _onclickFavorite,
              color: color,
            ),
            IconButton(icon: Icon(Icons.share), onPressed: _onclickShare)
          ],
        ),
      ],
    );
  }

  void _onclickMapa(Carro c) {
    navigator(context,MapaPage(c),replace: false);
  }

  void _onclickVideo(Carro c) {
   navigator(context,YoutubePage(c),replace: false);
  }

  _onclickMenuButton(value) {
    switch (value) {
      case "Editar":
        navigator(context, CarroFormPage(carro: widget.carro));
        break;
      case "Deletar":
        deletar();
        break;
    }
  }

  void _onclickFavorite() async {
    bool exists = await FavoritoService().favoritar(widget.carro);
    setState(() {
      color = !exists ? Colors.red : Colors.grey;
    });
  }

  void _onclickShare() {
    Share.share(widget.carro.urlFoto);
  }

  bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.carro.descricao,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
      ],
    );
  }

  void deletar() async {

    ApiResponse<bool> response = await CarroApi.deleteFirebase(widget.carro);
    if (response.ok) {
      alert(context, "Item Deletado com sucesso!", calback: () {
        Navigator.pop(context);
      });
    } else {
      alert(context, response.mensagem);
    }
  }
}
