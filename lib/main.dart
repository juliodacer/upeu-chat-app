import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upeu_chat_app/chatScreen.dart';
import 'package:upeu_chat_app/login.dart';

main() async {
  //Inicializar firebase
  //también agregue multi Dex en el gradle
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences pref = await SharedPreferences.getInstance();

  //obtener email a traves de la clave "email"
  var email = pref.getString("email");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    
    //Cuando la app se reinicie seguirá la sesion iniciada en el chatScreen
    //Si cerramos sesion seremos redireccionados a LoginPage
    home: email == null ? LoginPage() : ChatScreen(),
  ));
}


