import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upeu_chat_app/firebaseHelper.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Service service = Service();

  final auth = FirebaseAuth.instance;

  getCurrentUser() {
    final user = auth.currentUser;

    //Si el usuario no es vacio, se le asinga el usuario logueado
    if (user != null) {
      loginUser = user;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  service.signOut(context);
                  // Aqui eliminaremos la clave cuando el usuario haga clic en el botón LogOut
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.remove("email");
                  //Se elimina el email del usuario logueado haciendo click en el boton logOut
                },
                icon: Icon(Icons.logout))
          ],
          title: Text(loginUser!.email.toString())),
    );
  }
}
