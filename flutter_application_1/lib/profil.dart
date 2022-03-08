class Profil {
  // attributs
  String _email = "";
  String _token = "";

  // constructeurs
  Profil(this._email, this._token);
  Profil.vierge();

  // getter et setter
  String getEmail() {
    return _email;
  }

  String getToken() {
    return _token;
  }
}
