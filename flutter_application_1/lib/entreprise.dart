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

  String getIdEntreprise() {
    return _id;
  }

  String getNomEntreprise() {
    return _nom;
  }

  String getDescriptionEntreprise() {
    return _description;
  }

  String getAdresseVilleEntreprise() {
    return _adresseVille;
  }

  String getAdresseRegionEntreprise() {
    return _adresseRegion;
  }

  String getAdresseCPEntreprise() {
    return _adresseCP;
  }

  DateTime getDateCreationPage() {
    return _dateCreationPage;
  }

  List getFavori() {
    return _misEnFavori;
  }

  set setId(String value) => this._id = value;
  set setNom(value) => this._nom = value;
  set setDescription(value) => this._description = value;
  set setAdresseVille(value) => this._adresseVille = value;
  set setAdresseRegion(value) => this._adresseRegion = value;
  set setAdresseCP(value) => this._adresseCP = value;
  set setDateCreationPage(value) => this._dateCreationPage = value;
  set setMisEnFavori(value) => this._misEnFavori = value;
}
