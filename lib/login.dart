import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upeu_chat_app/firebaseHelper.dart';
import 'package:upeu_chat_app/login.dart';
import 'package:upeu_chat_app/register.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  //instancia de la clase Service
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    "Iniciar Sesión",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  Center(
                      child: Card(
                          child: SizedBox(
                              width: 70, height: 70, child: FlutterLogo()))),
                  Text(
                    "UPeU Chat",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    autofocus: true,
                    autocorrect: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Correo Electrónico",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        helperText: "tucorreo@ejemplo.com"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    height: 55,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.blue,
                      child: Text(
                        "Iniciar Sesión",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        //Si el correo y la contraseña no estan vacias
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          service.loginUser(context, emailController.text,
                              passwordController.text);

                          //guardará el email del usuario en la clave de email
                          //desde esta clave, verificaremos si el correo electrónico está presente en la clave, irá a ChatScreen, de lo contrario, a LoginPage
                          pref.setString("email", emailController.text);
                        } else {
                          //Si estan los campos vacios mostrará un mensaje de advertencia
                          service.errorBox(context,
                              "los campos no deben estar vacíos, ingrese un correo electrónico y una contraseña válidos");
                        }
                      },
                    ),
                  ),
                  Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text("No Tengo una cuenta"))
                    ],
                  )
                ],
              ),
            )));
  }
}
