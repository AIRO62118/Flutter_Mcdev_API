import 'package:flutter/material.dart';

import 'affichepage.dart';
import 'myhomepage.dart';
import 'profilpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MDCev - API',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const MyHomePage(title: 'Connexion'),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/affiche': (BuildContext context) => AffichePage(title: 'Affichage'),
          '/profil': (BuildContext context) =>
              ProfilPage(title: 'Votre Profil'),
          '/entreprise': (BuildContext context) =>
              ProfilPage(title: 'Votre Entreprise')
        });
  }
}
