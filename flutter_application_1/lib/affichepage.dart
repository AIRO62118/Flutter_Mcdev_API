// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/profil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AffichePage extends StatefulWidget {
  const AffichePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AffichePage> createState() => _AffichePageState();
}

class _AffichePageState extends State<AffichePage> {
  Profil profil = Profil.vierge();
  Map<String, dynamic> dataMap = new Map();

  Widget afficheData() {
    Column contenu = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.empty(growable: true),
    );

    contenu.children.add(Text("Votre nom: " + profil.getNom().toString()));
    contenu.children
        .add(Text("Votre prénom: " + profil.getPrenom().toString()));
    contenu.children.add(Text("Votre email: " + profil.getEmail().toString()));
    contenu.children
        .add(Text("Votre ville: " + profil.getAdresseVille().toString()));

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
      body: Center(child: afficheData()),
    );
  }
}
