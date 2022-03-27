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
  Entreprise entreprise = Entreprise.vierge();
  Profil profil = Profil.vierge();

  String id = "";
  String nom = "";
  String description = "";
  String adresseVille = "";
  String adresseRegion = "";
  String adresseCP = "";
  late DateTime dateCreationPage;

  bool recupDataBool = false;
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
      nom = dataMap['nom_entreprise'].toString();
      description = dataMap['description_entreprise'].toString();
      adresseVille = dataMap['adresse_ville_e'].toString();
      adresseRegion = dataMap['adresse_region_e'].toString();
      adresseCP = dataMap['adresse_CPe'].toString();
      dateCreationPage =
          DateTime.parse(dataMap['date_création_page'].toString());
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

    //contenu.children.add(Text("Token: " + profil.getToken().toString()));
    print(profil.getToken());

    return contenu;
  }

  Widget boutonEntreprise() {
    ElevatedButton button = ElevatedButton(
        onPressed: () async {
          await afficheProfilEntreprise(entreprise.getId(), profil.getToken());
          if (recupDataBool) {
            entreprise = Entreprise(
                entreprise.getId(),
                entreprise.getNom(),
                entreprise.getDescription(),
                entreprise.getAdresseRegion(),
                entreprise.getAdresseVille(),
                entreprise.getAdresseCP(),
                entreprise.getDateCreationPage(),
                entreprise.getFavori());
            Navigator.pushNamed(context, '/entreprise', arguments: entreprise);
          }
        },
        child: Text("Voir votre entreprise"));
    return button;
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
          children: [afficheData(), boutonEntreprise()],
        ),
      ),
    );
  }
}
