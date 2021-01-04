import 'dart:async';

import 'package:auth_buttons/res/buttons/google_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/blocs/bloc_login.dart';
import 'package:flutter_pokemons/carros/home_page_carro.dart';
import 'package:flutter_pokemons/pokemons/home_page_pokemon.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';
import 'package:flutter_pokemons/ultil/alert.dart';
import 'package:flutter_pokemons/ultil/api_response.dart';
import 'package:flutter_pokemons/ultil/nav.dart';
import 'package:flutter_pokemons/widgets/button_page.dart';
import 'package:flutter_pokemons/widgets/text_page.dart';

import 'instancias/usuario.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bloc = BlocLogin();
  var _tlogin = TextEditingController();

  var _tsenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextPage(
              "Login",
              "Digite o Login",
              controller: _tlogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 20,
            ),
            TextPage(
              "Senha",
              "Digite a Senha",
              obscureText: true,
              controller: _tsenha,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
              stream: bloc.fetch,
              initialData: false,
              builder: (context, snapshot) {
                return ButtonPage(
                  "Login",
                  onPressed: (){
                    _onclick(context);
                  },
                  showProgress: snapshot.data,
                );
              }
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: GoogleAuthButton(
                onPressed: (){
                  _loginGoogle();
                },
                darkMode: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onclick(BuildContext context) async {
    bool formOk = _formKey.currentState.validate();
    if (!formOk) {
      return;
    }
    String login = _tlogin.text;
    String senha = _tsenha.text;
    print("login : " + login + " Senha : " + senha);
    ApiResponse apiResponse = await bloc.login(login, senha);
    if(apiResponse.ok){
      Usuario user = apiResponse.results;
      print(user);
      navigator(context,HomePageCarro(),replace: true);
    }
    else{
      alert(context,apiResponse.mensagem);
    }

  }

  String _validateLogin(String value) {
    if (value.isEmpty) {
      return "Digite o Login!";
    }
    return null;
  }

  String _validateSenha(String value) {
    if (value.isEmpty) {
      return "Digite a Senha!";
    }
    return null;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }

  _loginGoogle() async {
    final service = FirebaseService();
    ApiResponse apiResponse = await service.loginGoogle();
    if(apiResponse.ok){
      navigator(context,HomePageCarro(),replace: true);
    }
    else{
      alert(context, apiResponse.mensagem);
    }
  }
}
