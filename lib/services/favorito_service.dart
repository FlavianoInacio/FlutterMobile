import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';
import '../instancias/carro.dart';

class FavoritoService{
  CollectionReference get _users => FirebaseFirestore.instance.collection("users");
  Query get carros => _users.doc(firebaseUserId).collection("pokemons").where("favorito",isEqualTo: true);
  CollectionReference get pokemonsall => _users.doc(firebaseUserId).collection("pokemons");
  Stream<QuerySnapshot> get stream => carros.snapshots();

   Future<bool> favoritar(Carro c) async{
     DocumentReference docRef = pokemonsall.doc("${c.idFirebase}");
     final exists = await getCarroFavorito(c);
      if(!exists){
        c.favorito = true;
        docRef.set(c.toMap());
        return false;
      }
      else{
        docRef.delete();
        return true;
      }
  }
   Future<bool> getCarroFavorito(Carro c) async{
     Query docRef = pokemonsall.where("idFirebase",isEqualTo: c.idFirebase).where("favorito",isEqualTo: true);
     QuerySnapshot docsnapshot = await docRef.get();
     final exists = docsnapshot.size>0?true:false;
    return exists;
  }
}