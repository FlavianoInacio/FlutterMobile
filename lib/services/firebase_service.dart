import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pokemons/instancias/usuario.dart';
import 'package:flutter_pokemons/ultil/api_response.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

      UserCredential  result = await _auth.signInWithCredential(credential);
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
      user.save();
      return ApiResponse.ok(results: "user");
    } catch (e) {
      return ApiResponse.error("Erro ao tentar fazer o login!");
    }
  }

  Future<ApiResponse<String>> login(String email, String senha) async {
    try {

      UserCredential  result = await _auth.signInWithEmailAndPassword(email: email, password: senha);
      print(result.user);
      final User fuser = result.user;

      final user = Usuario(
        nome: fuser.displayName,
        login: fuser.email,
        email: fuser.email,
        urlFoto: fuser.photoURL,
      );
      user.save();
      return ApiResponse.ok();
    } catch (e) {
      return ApiResponse.error("Erro ao tentar fazer o login!");
    }
  }

  Future<void> logout() async{
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
