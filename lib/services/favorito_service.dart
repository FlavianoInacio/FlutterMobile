import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pokemons/services/firebase_service.dart';
import '../instancias/carro.dart';

class FavoritoService{
  CollectionReference get _users => FirebaseFirestore.instance.collection("users");
  CollectionReference get _carros => _users.doc(firebaseUserId).collection("carros");
  Stream<QuerySnapshot> get stream => _carros.snapshots();

   Future<bool> favoritar(Carro c) async{
     DocumentReference docRef = _carros.doc("${c.id}");
     DocumentSnapshot docsnapshot = await docRef.get();
     final exists = docsnapshot.exists;
      if(!exists){
        docRef.set(c.toMap());
        return false;
      }
      else{
        docRef.delete();
        return true;
      }
  }
   Future<bool> getCarroFavorito(Carro c) async{
     DocumentReference docRef = _carros.doc("${c.id}");
     DocumentSnapshot docsnapshot = await docRef.get();
     final exists = docsnapshot.exists;
    return exists;
  }
}