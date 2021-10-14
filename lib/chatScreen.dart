import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upeu_chat_app/firebaseHelper.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Service service = Service();

  final storeMessage = FirebaseFirestore.instance;

  final auth = FirebaseAuth.instance;

  TextEditingController msg = TextEditingController();

  getCurrentUser() {
    final user = auth.currentUser;

    if (user != null) {
      loginUser = user;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
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
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.remove("email");
                  //Se elimina el email del usuario logueado haciendo click en el boton logOut
                },
                icon: Icon(Icons.logout))
          ],
          title: Text(loginUser!.email.toString())),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Aqui se muestran los mensajes
          Container(
            height: 500,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
                reverse: true,
                child: ShowMessages()),
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.brown, width: 0.2))),
                child: TextField(
                  controller: msg,
                  decoration:
                      InputDecoration(hintText: "Ingrese un mensaje..."),
                ),
              )),
              IconButton(
                  onPressed: () {
                    if (msg.text.isNotEmpty) {
                      storeMessage.collection("Messages").doc().set({
                        "messages": msg.text.trim(),
                        "user": loginUser!.email.toString(),
                        "time": DateTime.now()
                      });
                      msg.clear();
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.brown,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class ShowMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Messages").orderBy("time").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              //reverse: true,
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              primary: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: loginUser!.email == x['user']
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                         decoration: BoxDecoration(
                           color: loginUser!.email==x['user']
                               ? Colors.brown.withOpacity(0.2)
                               : Colors.amber.withOpacity(0.4),
                           borderRadius: BorderRadius.circular(8)
                         ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(x['messages'],
                             ),
                             SizedBox(height: 5),
                             Text(x['user'],
                             style: TextStyle(fontSize: 10),),
                           ],
                          ))
                    ],
                  ),
                );
              });
        });
  }
}
