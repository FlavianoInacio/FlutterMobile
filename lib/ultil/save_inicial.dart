import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';



void insert(Carro c) async {

  QuerySnapshot doc = await  FirebaseFirestore.instance.collection("users").doc(firebaseUserId).collection("pokemons").get();
  if(doc.size==0) {
    CollectionReference _users = FirebaseFirestore.instance.collection("users");
    CollectionReference _pokemons = _users.doc(firebaseUserId).collection("pokemons");
    DocumentReference docRef = _pokemons.doc();
    docRef.set(c.toMap()).then((value) {
      c.idFirebase = docRef.id;
      print("id >> ${docRef.id}");
      _pokemons.doc(docRef.id).update({"idFirebase":docRef.id}).then((value) {
        print("sucess!");
      });
    });

  }
}

void saveInicial() {
  Carro c = Carro(
      urlFoto: "https://pokestop.io/img/pokemon/charmander-256x256.png",
      nome: "Charmander",
      descricao: "Pokemon de Fogo",
      id: 1,
      latitude: "14.4747103",
      longitude: "-90.8893894",
      tipo: "Fogo",
      urlVideo: "uGtBcsAITfg"
  );
  Carro c1 = Carro(
      urlFoto: "https://pokestop.io/img/pokemon/bulbasaur-256x256.png",
      nome: "Bulbasaur",
      descricao: "Pokemon de Planta",
      id: 2,
      latitude: "-3.465305",
      longitude: "-62.2333901",
      tipo: "Planta",
      urlVideo: "v22MQ8ccwN8"
  );
  Carro c2 = Carro(
      urlFoto: "https://pokestop.io/img/pokemon/squirtle-256x256.png",
      nome: "Squirtle",
      descricao: "Pokemon de Água",
      id: 3,
      latitude: "-0.2494933",
      longitude: "-117.8246144",
      tipo: "Agua",
      urlVideo: "__FYSw-PvOs"
  );
  Carro c3 = Carro(
      urlFoto: "https://pokestop.io/img/pokemon/charmeleon-256x256.png",
      nome: "Charmeleon",
      descricao: "Pokemon de Fogo",
      id: 4,
      latitude: "14.4747103",
      longitude: "-90.8893894",
      tipo: "Fogo",
      urlVideo: "Y9N8d16Pntc"
  );
  Carro c4 = Carro(
      urlFoto: "https://pokestop.io/img/pokemon/ivysaur-256x256.png",
      nome: "Ivysaur",
      descricao: "Pokemon de Planta",
      id: 5,
      latitude: "-3.465305",
      longitude: "-62.2333901",
      tipo: "Planta",
      urlVideo: "jq0VzzmRckE"
  );
  Carro c5 = Carro(
      urlFoto: "https://pokestop.io/img/pokemon/wartortle-256x256.png",
      nome: "Wartortle",
      descricao: "Pokemon de Água",
      id: 6,
      latitude: "-0.2494933",
      longitude: "-117.8246144",
      tipo: "Agua",
      urlVideo: "B45NzDpfZHM"
  );
  Carro c6 = Carro(
      urlFoto: "https://pokestop.io/img/pokemon/charizard-256x256.png",
      nome: "Charizard",
      descricao: "Pokemon de Fogo",
      id: 7,
      latitude: "14.4747103",
      longitude: "-90.8893894",
      tipo: "Fogo",
      urlVideo: "UgcX7p0xArc"
  );
  Carro c7 = Carro(
      urlFoto: "https://pokestop.io/img/pokemon/venusaur-256x256.png",
      nome: "Venusaur",
      descricao: "Pokemon de Planta",
      id: 8,
      latitude: "-3.465305",
      longitude: "-62.2333901",
      tipo: "Planta",
      urlVideo: "nBInN5VbKyA"
  );
  Carro c8 = Carro(
      urlFoto: "https://pokestop.io/img/pokemon/blastoise-256x256.png",
      nome: "Blastoise",
      descricao: "Pokemon de Água",
      id: 9,
      latitude: "-0.2494933",
      longitude: "-117.8246144",
      tipo: "Agua",
      urlVideo: "fIX7mBMyKaY"
  );
  insert(c);
  insert(c1);
  insert(c2);
  insert(c3);
  insert(c4);
  insert(c5);
  insert(c6);
  insert(c7);
  insert(c8);
}