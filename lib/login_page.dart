import 'dart:async';

import 'package:auth_buttons/res/buttons/google_auth_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/blocs/bloc_login.dart';
import 'package:flutter_pokemons/carros/cadastro_usuario.dart';
import 'package:flutter_pokemons/carros/home_page_carro.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';
import 'package:flutter_pokemons/ultil/alert.dart';
import 'package:flutter_pokemons/ultil/api_response.dart';
import 'package:flutter_pokemons/ultil/nav.dart';
import 'package:flutter_pokemons/ultil/teddy_controller.dart';
import 'package:flutter_pokemons/widgets/button_page.dart';
import 'package:flutter_pokemons/widgets/text_page.dart';
import 'package:flutter_pokemons/widgets/tracking_text_input.dart';

import 'instancias/usuario.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TeddyController _teddyController;
  final bloc = BlocLogin();
  var _tlogin = TextEditingController();

  var _tsenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _teddyController = TeddyController();
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
    return Container(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              Container(
                  height: 200,
                  padding: const EdgeInsets.only(left: 30.0, right:30.0,bottom: 6),
                  child: FlareActor(
                    "assets/images/Teddy.flr",
                    shouldClip: false,
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.contain,
                    controller: _teddyController,
                  )),
              TrackingTextInput(
                  label: "Login",
                  hint: "Digite o Login",
                  textController: _tlogin,
                  validator: _validateLogin,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onCaretMoved: (Offset caret) {
                    _teddyController.lookAt(caret);
                  }),
              TrackingTextInput(
                label:"Senha",
                hint:"Digite a Senha",
                isObscured: true,
                textController: _tsenha,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                onCaretMoved: (Offset caret) {
                  _teddyController.coverEyes(caret != null);
                  _teddyController.lookAt(null);
                },
                onTextChanged: (String value) {
                  _teddyController.setPassword(value);
                },
              ),
              StreamBuilder<bool>(
                  stream: bloc.fetch,
                  initialData: false,
                  builder: (context, snapshot) {
                    return ButtonPage(
                      "Login",
                      onPressed: () {
                        _onclick(context);
                      },
                      showProgress: snapshot.data,
                    );
                  }),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: GoogleAuthButton(
                  buttonPadding: EdgeInsets.all(10),
                  onPressed: () {
                    _loginGoogle();
                  },
                  darkMode: false,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: InkWell(
                    onTap: _onclickCadastrar,
                    child: Text(
                      "Cadastre-se",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onclick(BuildContext context) async {
    bool formOk = _formKey.currentState.validate();
    if (!formOk) {
      _teddyController.submitPassword(false);
      return;
    }
    String login = _tlogin.text;
    String senha = _tsenha.text;
    print("login : " + login + " Senha : " + senha);
    ApiResponse apiResponse = await bloc.login(login, senha);
    if (apiResponse.ok) {
      _teddyController.submitPassword(true);
      Future.delayed(const Duration(seconds: 3), () {
        navigator(context, HomePageCarro(), replace: true);
      }
      );


    } else {
      _teddyController.submitPassword(false);
      alert(context, apiResponse.mensagem);
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
    if (apiResponse.ok) {
      _teddyController.submitPassword(true);
      navigator(context, HomePageCarro(), replace: true);
    } else {
      _teddyController.submitPassword(false);
      alert(context, apiResponse.mensagem);
    }
  }

  void _onclickCadastrar() {
    navigator(context, CadastroUsuario(), replace: true);
  }
}
