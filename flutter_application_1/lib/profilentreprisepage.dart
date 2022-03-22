import 'package:flutter/material.dart';
import 'package:flutter_application_1/profil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'entreprise.dart';

class ProfilEntreprisePage extends StatefulWidget {
  const ProfilEntreprisePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ProfilEntreprisePage> createState() => _ProfilEntreprisePageState();
}

class _ProfilEntreprisePageState extends State<ProfilEntreprisePage> {
  Entreprise entreprise = Entreprise.vierge();
  bool recupDataBool = false;

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
    contenu.children.add(
        Text("Devenu membre le :" + profil.getDateInscription().toString()));
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
    entreprise = ModalRoute.of(context)?.settings.arguments as Entreprise;

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