import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/instancias/usuario.dart';
import 'package:flutter_pokemons/ultil/api_response.dart';
import 'package:google_sign_in/google_sign_in.dart';

String firebaseUserId;

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse<String>> loginGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      print("Google User${googleUser.email}");

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      print(result.user);
      final User fuser = result.user;
      print("Firebase Name " + fuser.displayName);
      print("Firebase Email " + fuser.email);
      print("Firebase Foto " + fuser.photoURL);

      final user = Usuario(
        nome: fuser.displayName,
        login: fuser.email,
        email: fuser.email,
        urlFoto: fuser.photoURL,
      );
      saveUser(fuser);
      user.save();
      return ApiResponse.ok(results: "user");
    } catch (e) {
      return ApiResponse.error("Erro ao tentar fazer o login!");
    }
  }

  Future<ApiResponse<String>> login(String email, String senha) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: senha);
      print(result.user);
      final User fuser = result.user;

      final user = Usuario(
        nome: fuser.displayName,
        login: fuser.email,
        email: fuser.email,
        urlFoto: fuser.photoURL,
      );
      saveUser(fuser);
      user.save();
      return ApiResponse.ok();
    } catch (e) {
      return ApiResponse.error("Erro ao tentar fazer o login!");
    }
  }

  Future<ApiResponse<String>> cadastrar(String email, String senha, String nome,
      File file) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      print(result.user);
      final User fuser = result.user;
      String urlFotoDownload = await uploadFirebaseFoto(file);
      fuser.updateProfile(displayName: nome, photoURL: urlFotoDownload);
      //fuser.reload();

      final user = Usuario(
        nome: fuser.displayName,
        login: fuser.email,
        email: fuser.email,
        urlFoto: fuser.photoURL,
      );
      saveUser(fuser);
      user.save();
      return ApiResponse.ok();
    } on FirebaseAuthException catch (error) {
      String errormsg;
      print("code${error.code}");
      if (error.code == "weak-password") {
        errormsg = "Senha deve conter no mínimo 6 digitos";
      }
      if (error.code == "email-already-in-use") {
        errormsg = "E-mail já existente";
      }
      return ApiResponse.error("Erro ao tentar fazer o login! ${errormsg}");
    }
  }

  void saveUser(User user) {
    if (user != null) {
      firebaseUserId = user.uid;
      DocumentReference rfuser = FirebaseFirestore.instance.collection("users")
          .doc(firebaseUserId);
      rfuser.set({
        'nome': user.displayName,
        'email': user.email,
        'login': user.email,
        'urlFoto': user.photoURL
      });
    }
  }

  void saveInicial() {
    CollectionReference _users = FirebaseFirestore.instance.collection("users");
    CollectionReference _carros = _users.doc(firebaseUserId).collection(
        "pokemons");
    Carro c = Carro(
      urlFoto: "https://img.favpng.com/23/11/19/pok-mon-x-and-y-pok-mon-go-charmander-bulbasaur-png-favpng-98YaXQZ0nhR5dfexbyMxfgNNB_t.jpg",
      nome: "Charmander",
      descricao: "Pokemon Brother",
      id: 1,
      latitude: "-23.564224",
      longitude: "-46.653156",
      tipo: "Fogo",
      urlVideo: "https://www.youtube.com/watch?v=uGtBcsAITfg"
    );
    DocumentReference docRef = _carros.doc("${c.id}");
    docRef.set(c.toMap());
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<String> uploadFirebaseFoto(File file) async {
    String fileName = file.path;
    final storeRef = FirebaseStorage.instance.ref().child(fileName);
    TaskSnapshot taskSnapshot = await storeRef.putFile(file);
    final String urlFoto = await taskSnapshot.ref.getDownloadURL();
    return urlFoto;
  }
}
