import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'file:///C:/Users/flaviano.inacio/AndroidStudioProjects/flutter_pokemons/lib/carros/home_page_carro.dart';
import 'package:flutter_pokemons/instancias/usuario.dart';
import 'package:flutter_pokemons/login_page.dart';
import 'package:flutter_pokemons/ultil/nav.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';

import 'github_page.dart';


class DrawerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            _header(user),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Sobre o Desenvolvedor",style: TextStyle(color: Colors.black),),
              subtitle: Text("Informações sobre o desenvolvimento do aplicativo..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                navigator(context,HomePageCarro());
              },
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text("Acesso o GitHub"),
              subtitle: Text("Informações do github e todos os repositórios..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                Navigator.pop(context);
                navigator(context,GitHubPage());
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Versão do aplicativo",style: TextStyle(color: Colors.blue),),
              subtitle: Text("Versão de desenvolviento do aplicativo"),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                Fluttertoast.showToast(
                    msg: "Versão 1.0",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black26,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                _logout(context);
              },
            )
          ],
        ),

      ),
    );
  }

  UserAccountsDrawerHeader _header(User user) {
    return UserAccountsDrawerHeader(
            accountName: user.displayName!=null?Text(user.displayName):Text(""),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage:  user.photoURL!=null?NetworkImage(user.photoURL):
              AssetImage('assets/images/naoencontrada.png'),),
          );
  }

  void _logout(context) {
    Usuario.clear();
    FirebaseService().logout();
    navigator(context, LoginPage(),replace: true);
  }
}