// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/profil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'entreprise.dart';

class AffichePage extends StatefulWidget {
  const AffichePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AffichePage> createState() => _AffichePageState();
}

class _AffichePageState extends State<AffichePage> {
  Profil profil = Profil.vierge();
  String email = "";
  String password = "";
  String token = "";
  String adresseVille = "";
  String adresseRegion = "";
  String adresseCP = "";
  String nom = "";
  String prenom = "";
  Entreprise? patron;
  late DateTime dateDeNaissance;
  late DateTime dateInscription;

  Map<String, dynamic> dataMap = new Map();
  bool recupDataBool = false;

  Widget afficheData() {
    Column contenu = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.empty(growable: true),
    );

    contenu.children.add(Text("Bonjour " +
        profil.getPrenom().toString() +
        " " +
        profil.getNom().toString()));
    /* +
        ", " +
        profil.afficheAge().toString() +
        " ans"));
*/

    return contenu;
  }

  Future<void> afficheProfil(String id, String token) async {
    String url = "http://s3-4393.nuage-peda.fr/mcdev/api/users/" + id;
    var reponse = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      },
    );
    if (reponse.statusCode == 200) {
      dataMap = convert.jsonDecode(reponse.body);
      id = dataMap['id'].toString();
      adresseVille = dataMap['adresse_ville'].toString();
      adresseRegion = dataMap['adresse_region'].toString();
      adresseCP = dataMap['adresse_CP'].toString();
      nom = dataMap['nom'].toString();
      prenom = dataMap['prenom'].toString();
      dateInscription = DateTime.parse(dataMap['date_inscription'].toString());
      dateDeNaissance = DateTime.parse(dataMap['date_de_naissance'].toString());
      if (dataMap.containsKey('est_patron')) {
        patron = Entreprise(
            dataMap['est_patron']['id'].toString(),
            dataMap['est_patron']['nom_entreprise'].toString(),
            dataMap['est_patron']['description_entreprise'].toString(),
            dataMap['est_patron']['adresse_ville_e'].toString(),
            dataMap['est_patron']['adresse_region_e'].toString(),
            dataMap['est_patron']['adresse_CPe'].toString(),
            DateTime.parse(
                dataMap['est_patron']['date_création_page'].toString()),
            dataMap['est_patron']['interessers']);
      }
      recupDataBool = true;
    } else {
      print("Probleme API GET user");
    }
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
        children: [
          afficheData(),
          ElevatedButton(
              onPressed: () async {
                await afficheProfil(profil.getId(), profil.getToken());
                if (recupDataBool) {
                  profil = Profil(
                      profil.getId(),
                      profil.getEmail(),
                      profil.getToken(),
                      adresseVille,
                      nom,
                      prenom,
                      adresseRegion,
                      adresseCP,
                      dateDeNaissance,
                      dateInscription);
                  Navigator.pushNamed(context, '/profil', arguments: profil);
                }
              },
              child: Text("Voir votre profil"))
        ],
      )),
    );
  }
}
