import 'package:flutter_pokemons/instancias/entity.dart';

class Pokemon extends Entity{

  String nome;
  String urldetalhe;
  String urlfoto;
  String urlfotodetalhe;
  int id;
  List<String> tipos = List<String>();

  @override
  String toString() {
    return 'Pokemon{nome: $nome, id: $id, tipos: $tipos}';
  }

  void add(String tipo) {
    if (tipo != null) {
      tipos.add(tipo);
    }
  }

  Pokemon.fromMap(Map<String, dynamic> map)
      :
        nome = map["name"],
        urldetalhe = map["url"],
        id = map["id"];

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }

}