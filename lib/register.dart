import 'package:flutter/material.dart';
import 'package:upeu_chat_app/firebaseHelper.dart';
import 'package:upeu_chat_app/login.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///instancia de la clase Service
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Regístrate",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "UPeU Chat App",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Ingrese su email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Ingrese su contraseña",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      )
                  ),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 80),
                      ),
                      onPressed: () {
                        ///Si el correo y la contraseña no estan vacias
                          if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                              service.createUser(context, emailController.text, passwordController.text);
                          }else {
                            ///Si estan los campos vacios mostrará un mensaje de advertencia
                            service.errorBox(context, "los campos no deben estar vacíos, ingrese un correo electrónico y una contraseña válidos");
                          }
                      },
                      child: Text("Registrarse")),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                  }, child: Text("Tengo una cuenta, inicar sesión"))
                ],
              )
          ),
        )
    );
  }
}