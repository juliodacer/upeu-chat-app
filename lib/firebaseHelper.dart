import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upeu_chat_app/chatScreen.dart';
import 'package:upeu_chat_app/login.dart';

class Service {
  final auth = FirebaseAuth.instance;

  //funcion para crear usuario (recibe 3 parametros)
  void createUser(context, email, password) async {
    try {
      //cuando el usuario es creado sera redireccionado automanticamente a ChaScreen
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()))
              });
    } catch (e) {
      errorBox(context, e);
    }
  }

  //funcion para loguear usuario
  void loginUser(context, email, password) async {
    try {
      //cuando el usuario es logueado y sera redireccionado automanticamente a ChaScreen
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()))
              });
    } catch (e) {
      errorBox(context, e);
    }
  }

  //Cerrar sesión
  void signOut(context) async {
    try {
      await auth.signOut().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false)
          });
    } catch (e) {
      errorBox(context, e);
    }
  }

  //mensaje de error
  void errorBox(context, e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(e.toString()),
          );
        });
  }
}
