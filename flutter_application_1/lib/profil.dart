class Profil {
  // attributs
  String _email = "";
  String _token = "";
  String _nom = "";
  String _prenom = "";
  String _adresseVille = "";

  // constructeurs
  Profil(this._email, this._token, this._adresseVille, this._nom, this._prenom);
  Profil.vierge();

  // getter et setter
  String getEmail() {
    return _email;
  }

  String getToken() {
    return _token;
  }

  String getAdresseVille() {
    return _adresseVille;
  }

  String getNom() {
    return _nom;
  }

  String getPrenom() {
    return _prenom;
  }
}
