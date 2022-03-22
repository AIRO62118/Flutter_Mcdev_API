class Entreprise {
  //Attributs
  String _id = "";
  String _nom = "";
  String _description = "";
  String _adresseVille = "";
  String _adresseRegion = "";
  String _adresseCP = "";
  DateTime _dateCreationPage = DateTime.now();
  List _misEnFavori = [];

  //Constructeurs
  Entreprise(
      this._id,
      this._nom,
      this._description,
      this._adresseRegion,
      this._adresseVille,
      this._adresseCP,
      this._dateCreationPage,
      this._misEnFavori);

  Entreprise.vierge();

  //Getter et Setter

  String getId() {
    return _id;
  }

  String getNom() {
    return _nom;
  }

  String getDescription() {
    return _description;
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

  DateTime getDateCreationPage() {
    return _dateCreationPage;
  }

  List getFavori() {
    return _misEnFavori;
  }
}
