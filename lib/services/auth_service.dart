import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  String message = '';
  String _userId;
  User _user;

  Future register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      message = userCredential.additionalUserInfo.username;
      User user = auth.currentUser;
      if (!isEmailVerified()) {
        await user.sendEmailVerification();
      }
      return message ?? 'Registo Efectuado com Sucesso';
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        message = 'Palavra-passe demasiado fraca';
      } else if (e.code == 'email-already-in-use') {
        message = 'Conta com o email fornecido já existente';
      }

      return message;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      message = userCredential.additionalUserInfo.username;
      if (isEmailVerified()) {
        _userId = userCredential.user.uid;
        message = 'Login Efectuado com Sucesso\nParabéns, ganhou acesso à Dapp';
        notifyListeners();
      }
      return message ??
          'Login Efectuado com Sucesso\nAguardando Confirmação de email';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'Utilizador com email fornecido não encontrado';
      } else if (e.code == 'wrong-password') {
        message = 'Password errada para este utilizador ou Conta não existente';
      }
      return message;
    }
  }

  Future signInWithGoogle() async {
    try {
      //aciona o serviço de autenticação google
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      //criação de credencias para autenticar o utilizador na aplicação
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      //com a credencial é possivel então efectuar a autenticação do utilizador
      return await auth
          .signInWithCredential(credential)
          .whenComplete(() {})
          .then((value) {
        _userId = value.user.uid;
        _user = value.user;
        print(_userId);
        message = 'Login Efectuado com Sucesso\nParabéns, ganhou acesso à Dapp';
        notifyListeners();
        return message;
      });
      //tratamento de excepções
    } on FirebaseAuthException catch (e) {
      return 'Erro ao autenticar conta  \n$e';
    }
  }

  String get userId => _userId;
  User get user => _user;

  bool isEmailVerified() {
    User user = auth.currentUser;
    return user.emailVerified;
  }
}
