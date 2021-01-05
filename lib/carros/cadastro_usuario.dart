import 'package:flutter/material.dart';
import 'package:flutter_pokemons/carros/home_page_carro.dart';
import 'package:flutter_pokemons/login_page.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';
import 'package:flutter_pokemons/ultil/alert.dart';
import 'package:flutter_pokemons/ultil/api_response.dart';
import 'package:flutter_pokemons/ultil/nav.dart';
import 'package:flutter_pokemons/widgets/button_page.dart';
import 'package:flutter_pokemons/widgets/text_page.dart';

class CadastroUsuario extends StatefulWidget {
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  var _tnome = TextEditingController();
  var _temail = TextEditingController();
  var _tsenha = TextEditingController();
  bool _progress = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de usuário"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(12),
          child: ListView(
            children: [
              TextPage(
                "Nome",
                "Digite o nome",
                controller: _tnome,
                validator: _validatorNome,
                textInputAction: TextInputAction.next,
                labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextPage(
                "E-mail",
                "Digite o E-mail",
                validator: _validatorEmail,
                controller: _temail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextPage(
                "Senha",
                "Digite a Senha",
                controller: _tsenha,
                validator: _validatorSenha,
                keyboardType: TextInputType.number,
                obscureText: true,
                labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              ButtonPage(
                "Cadastrar",
                showProgress: _progress,
                onPressed: _conclickCadastrar,
              ),
              SizedBox(
                height: 5,
              ),
              ButtonPage(
                "Cancelar",
                onPressed: _conclickCancelar,
                buttonColor: Colors.white,
                textButtonColor: TextStyle(color: Colors.blue, fontSize: 22),
              ),
            ],
          ),
        ));
  }

  String _validatorNome(String value) {
    if (value.isEmpty) {
      return "Digite o login!";
    }
    return null;
  }

  String _validatorEmail(String value) {
    if (value.isEmpty) {
      return "Digite o E-mail!";
    }
    return null;
  }

  String _validatorSenha(String value) {
    if (value.isEmpty) {
      return "Digite a Senha";
    }
    return null;
  }

  _conclickCadastrar() async {
    bool formOk = _formKey.currentState.validate();
    if(!formOk){
      return;
    }
    setState(() {
      _progress = true;
    });
    String nome = _tnome.text;
    String email = _temail.text;
    String senha = _tsenha.text;
    ApiResponse apiResponse = await FirebaseService().cadastrar(email, senha, nome);
    if(apiResponse.ok){
      navigator(context, HomePageCarro(), replace: true);
    }
    else{
      alert(context, apiResponse.mensagem);
      setState(() {
        _progress = false;
      });
    }
  }

  _conclickCancelar() {
    navigator(context, LoginPage(),replace: true);
  }
}
