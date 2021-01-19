import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class PaginaPessoal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página Pessoal"),
      ),
      body: _body(),
    );
  }
  _body(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Image.asset("assets/images/perfil.png",height: 200,),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Text("Flaviano Inácio",style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.topLeft,
            child: Text("Analista de Sistemas",style: TextStyle(
                fontSize: 20,
                color: Colors.black
            ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text("E-mail : "+ "flaviano.s.inacio@gmail.com",style: TextStyle(
                fontSize: 15,
                color: Colors.black
            ),
            ),
          )
        ],
      ),
    );
  }
}
