// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/profil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'entreprise.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  Profil profil = Profil.vierge();
  Entreprise entreprise = Entreprise.vierge();
/*
   String id = "";
  String nom = "";
  String description = "";
  String adresseVille = "";
  String adresseRegion = "";
  String adresseCP = "";
  late DateTime dateCreationPage;
  late List misEnFavoris = [];
 */

  bool recupDataBool = false;
  bool afficheEntreprise = false;
  Map<String, dynamic> dataMap = new Map();

  Future<void> afficheProfilEntreprise(String id, String token) async {
    String url = "http://s3-4393.nuage-peda.fr/mcdev/api/entreprises/" + id;
    var reponse = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      },
    );
    if (reponse.statusCode == 200) {
      dataMap = convert.jsonDecode(reponse.body);
      print(dataMap);
      id = dataMap['id'].toString();
      entreprise.setNom = dataMap['nom_entreprise'].toString();
      entreprise.setDescription = dataMap['description_entreprise'].toString();
      entreprise.setAdresseVille = dataMap['adresse_ville_e'].toString();
      entreprise.setAdresseRegion = dataMap['adresse_region_e'].toString();
      entreprise.setAdresseCP = dataMap['adresse_CPe'].toString();
      entreprise.setDateCreationPage =
          DateTime.parse(dataMap['date_création_page'].toString());
      entreprise.setMisEnFavori = dataMap['interessers'];
      recupDataBool = true;
    } else {
      print(reponse.statusCode);
    }
  }

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

    print(profil.getToken());

    return contenu;
  }

  verifEntreprise() async {
    print('le debug');
    print('le debug 2');
    await afficheProfilEntreprise(
        entreprise.getIdEntreprise(), profil.getToken());
    if (recupDataBool) {
      print('le debug 3');
      entreprise = Entreprise(
          entreprise.getIdEntreprise(),
          entreprise.getNomEntreprise(),
          entreprise.getDescriptionEntreprise(),
          entreprise.getAdresseVilleEntreprise(),
          entreprise.getAdresseRegionEntreprise(),
          entreprise.getAdresseCPEntreprise(),
          entreprise.getDateCreationPage(),
          entreprise.getFavori());
      Navigator.pushNamed(context, '/entreprise', arguments: entreprise);
    }
  }

  Widget boutonEntreprise() {
    ElevatedButton button = ElevatedButton(
        onPressed: afficheEntreprise ? verifEntreprise : null,
        child: afficheEntreprise ? Text("Voir votre entreprise") : null);
    return button;
  }

  @override
  Widget build(BuildContext context) {
    // recup l'argument profil
    profil = ModalRoute.of(context)?.settings.arguments as Profil;

    if (profil.getEntreprise().getIdEntreprise() != "") {
      entreprise = profil.getEntreprise();
      setState(() {
        afficheEntreprise = true;
      });
    }
    //entreprise = profil.patron;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [afficheData(), boutonEntreprise()],
        ),
      ),
    );
  }
}
