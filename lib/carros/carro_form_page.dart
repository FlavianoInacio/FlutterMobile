import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/api/carro_api.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/ultil/alert.dart';
import 'package:flutter_pokemons/ultil/api_response.dart';
import 'package:flutter_pokemons/ultil/event_bus.dart';
import 'package:flutter_pokemons/widgets/button_page.dart';
import 'package:flutter_pokemons/widgets/text_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CarroFormPage extends StatefulWidget {
  final Carro carro;

  CarroFormPage({this.carro});

  @override
  State<StatefulWidget> createState() => _CarroFormPageState();
}

class _CarroFormPageState extends State<CarroFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final tNome = TextEditingController();
  final tDesc = TextEditingController();
  final tTipo = TextEditingController();
  File _file;

  int _radioIndex = 0;

  var _showProgress = false;

  Carro get carro => widget.carro;

  // Add validate email function.
  String _validateNome(String value) {
    if (value.isEmpty) {
      return 'Informe o nome do Pokemon.';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    // Copia os dados do carro para o form
    if (carro != null) {
      tNome.text = carro.nome;
      tDesc.text = carro.descricao;
      _radioIndex = getTipoInt(carro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          carro != null ? carro.nome : "Novo Pokemon",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  _form() {
    return Form(
      key: this._formKey,
      child: ListView(
        children: <Widget>[
          _headerFoto(),
          Text(
            "Clique na imagem para tirar uma foto",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Divider(),
          Text(
            "Tipo",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 15,
            ),
          ),
          _radioTipo(),
          Divider(),
          TextPage(
            "Nome",
            "",
            controller: tNome,
            keyboardType: TextInputType.text,
            validator: _validateNome,
          ),
          SizedBox(
            height: 10,
          ),
          TextPage(
            "Descrição",
            "",
            controller: tDesc,
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 20,
          ),
          ButtonPage(
            "Salvar",
            onPressed: _onClickSalvar,
            showProgress: _showProgress,
          ),
        ],
      ),
    );
  }

  _headerFoto() {
    return InkWell(
      onTap: clickCamera,
        child: _file != null
            ? Image.file(_file,height: 150,)
            : carro != null
                ? carro.urlFoto != null
                    ? CachedNetworkImage(
                        imageUrl: carro.urlFoto,
                      )
                    : Image.asset(
                        "assets/images/naoencontrada.png",
                        height: 150,
                      )
                : Image.asset(
                    "assets/images/image.png",
                    height: 150,
                  ));
  }

  _radioTipo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Fogo",
          style: TextStyle(color: Colors.blue, fontSize: 12),
        ),
        Radio(
          value: 1,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Água",
          style: TextStyle(color: Colors.blue, fontSize: 12),
        ),
        Radio(
          value: 2,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Planta",
          style: TextStyle(color: Colors.blue, fontSize: 12),
        ),
      ],
    );
  }

  void _onClickTipo(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  getTipoInt(Carro carro) {
    switch (carro.tipo) {
      case "Fogo":
        return 0;
      case "Agua":
        return 1;
      default:
        return 2;
    }
  }

  String _getTipo() {
    switch (_radioIndex) {
      case 0:
        return "Fogo";
      case 1:
        return "Agua";
      default:
        return "Planta";
    }
  }

  _onClickSalvar() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    // Cria o carro
    var c = carro ?? Carro();
    c.nome = tNome.text;
    c.descricao = tDesc.text;
    c.tipo = _getTipo();

    print("Carro: $c");

    setState(() {
      _showProgress = true;
    });

    print("Salvar o carro $c");

    //await Future.delayed(Duration(seconds: 3));

    ApiResponse<bool> response = await CarroApi.saveFirebase(c,_file);
    if (response.ok) {
      alert(context, "Item salvo com sucesso!", calback: () {
       // Provider.of<EventBus>(context,listen: false).sendEvent("Carro_salvo");
        Navigator.pop(context);
        if(carro != null){
          Navigator.pop(context);
        }

      });
    } else {
      alert(context, response.mensagem);
    }

    setState(() {
      _showProgress = false;
    });

    print("Fim.");
  }

  void clickCamera() async {
    final picker = ImagePicker();
    PickedFile image = await picker.getImage(source:ImageSource.gallery);
    //File pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _file = File(image.path);
      });
    }
  }
}
