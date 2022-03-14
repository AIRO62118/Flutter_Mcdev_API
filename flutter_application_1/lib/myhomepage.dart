// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'profil.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  Profil profil = Profil.vierge();
  String email = "";
  String password = "";
  String token = "";
  String adresseVille = "";
  String nom = "";
  String prenom = "";

  Map<String, dynamic> dataMap = new Map();
  bool recupDataBool = false;

  // récupère le token
  Future<http.Response> verifToken(String email, String password) {
    return http.post(
      Uri.parse("http://s3-4393.nuage-peda.fr/mcdev/api/authentication_token"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert
          .jsonEncode(<String, String>{"email": email, "password": password}),
    );
  }

  Future<void> recupDataJson() async {
    http.Response reponse = await verifToken(email, password);
    if (reponse.statusCode == 200) {
      dataMap = convert.jsonDecode(reponse.body);
      token = dataMap['token'].toString();
      adresseVille = dataMap['data']['adresse_Ville'].toString();
      nom = dataMap['data']['nom'].toString();
      prenom = dataMap['data']['prenom'].toString();

      recupDataBool = true;
    } else {
      print("erreur " + reponse.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // login
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    hintText: "Saisir votre email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Erreur de saisie";
                  } else {
                    email = value;
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
              ),
              // password
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mot de passe",
                    hintText: "Saisir votre mot de passe password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Erreur de saisie";
                  } else {
                    password = value;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      await recupDataJson();
                      if (recupDataBool) {
                        profil =
                            Profil(email, token, adresseVille, nom, prenom);
                        Navigator.pushNamed(context, '/affiche',
                            arguments: profil);
                        /* ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(profil.toString())),
                        ); */
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Erreur dans la connection à la BDD"),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Erreur dans le login/mdp"),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
