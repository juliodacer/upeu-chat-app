import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
               "Iniciar Sesión",
               style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
             ),
             Text(
               "UPeU Chat App",
               style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                   padding: EdgeInsets.symmetric(horizontal: 80)
                 ),
                 onPressed: () {}, child: Text("Iniciar Sesión"))
           ],
         )
       ),
     )
   );
  }
}
