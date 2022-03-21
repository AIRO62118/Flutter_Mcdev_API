import 'package:flutter/material.dart';
import 'package:flutter_application_1/profil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  Profil profil = Profil.vierge();

  Map<String, dynamic> dataMap = new Map();

  Widget afficheData() {
    Column contenu = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.empty(growable: true),
    );

    contenu.children.add(Text("Bonjour " +
        profil.getPrenom().toString() +
        " " +
        profil.getNom().toString() +
        ", " +
        profil.afficheAge().toString() +
        " ans"));

    contenu.children.add(Text(profil.getEmail().toString()));
    contenu.children.add(Text(profil.getAdresseRegion() +
        ", " +
        profil.getAdresseVille().toString() +
        ", " +
        profil.getAdresseCP().toString()));

    //contenu.children.add(Text("Token: " + profil.getToken().toString()));
    print(profil.getToken());

    return contenu;
  }

  @override
  Widget build(BuildContext context) {
    // recup l'argument profil
    profil = ModalRoute.of(context)?.settings.arguments as Profil;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [afficheData()],
        ),
      ),
    );
  }
}
