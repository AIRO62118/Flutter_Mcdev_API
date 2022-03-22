import 'package:flutter_application_1/entreprise.dart';

class Profil {
  // attributs
  String _id = "";
  String _email = "";
  String _token = "";
  String _nom = "";
  String _prenom = "";
  String _adresseVille = "";
  String _adresseRegion = "";
  String _adresseCP = "";
  DateTime _dateDeNaissance = DateTime.now();
  DateTime _dateInscription = DateTime.now();
  Entreprise? patron;

  // constructeurs
  Profil(
      this._id,
      this._email,
      this._token,
      this._nom,
      this._prenom,
      this._adresseRegion,
      this._adresseVille,
      this._adresseCP,
      this._dateDeNaissance,
      this._dateInscription,
      {this.patron});

  Profil.vierge();

  // getter et setter
  String getId() {
    return _id;
  }

  String getEmail() {
    return _email;
  }

  String getToken() {
    return _token;
  }

  String getAdresseVille() {
    return _adresseVille;
  }

  String getAdresseRegion() {
    return _adresseRegion;
  }

  String getAdresseCP() {
    return _adresseCP;
  }

  String getNom() {
    return _nom;
  }

  String getPrenom() {
    return _prenom;
  }

  DateTime getDateDeNaissance() {
    return _dateDeNaissance;
  }

  DateTime getDateInscription() {
    return _dateInscription;
  }

  afficheAge() {
    DateTime dateAujourdhui = DateTime.now();
    if (dateAujourdhui.isAfter(_dateDeNaissance)) {
      int age = dateAujourdhui.year - _dateDeNaissance.year;
      int moisAujourdhui = dateAujourdhui.month;
      int moisAnniversaire = _dateDeNaissance.month;

      if (moisAnniversaire == moisAujourdhui) {
        age--;
      } else if (moisAnniversaire == moisAujourdhui) {
        int jourAujourdhui = dateAujourdhui.day;
        int jourAnniversaire = _dateDeNaissance.day;
        if (jourAnniversaire > jourAujourdhui) {
          age--;
        }
      }
      return age;
    } else {
      return "Erreur sur l'âge";
    }
  }
}
