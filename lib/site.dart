import 'package:firebase_database/firebase_database.dart';

class Site {
  String _id;
  String _nomSite;
  String _commune;
  String _departement;
  String _region;
  String _lattitude;
  String _longitude;
  String _etat;
  String _dateservie;
  String _lastdate;
  String _village;
  String _typeOuvrage;
  String _sysLavMain;
  String _popMenage;

  Site(this._id, this._nomSite, this._commune, this._departement, this._region, this._lattitude, this._longitude, this._etat, this._dateservie, this._lastdate);

  Site.map(dynamic obj){
    this._id = obj['id'];
    this._nomSite = obj['nomSite'];
    this._commune = obj['commune'];
    this._departement = obj['departement'];
    this._region = obj['region'];
    this._lattitude = obj['lattitude'];
    this._longitude = obj['longitude'];
    this._etat = obj['etat'];
    this._dateservie = obj['dateservie'];
    this._lastdate = obj['lastdate'];
    this._village = obj['village'];
    this._typeOuvrage = obj['typeOuvrage'];
    this._sysLavMain = obj['sysLavMain'];
    this._popMenage = obj['popMenage'];
  }

  String get id => _id;
  String get nomSite => _nomSite;
  String get commune => _commune;
  String get departement => _departement;
  String get region => _region;
  String get lattitude => _lattitude;
  String get longitude => _longitude;
  String get etat => _etat;
  String get dateservie => _dateservie;
  String get lastdate => _lastdate;
  String get village => _village;
  String get typeOuvrage => _typeOuvrage;
  String get sysLavMain => _sysLavMain;
  String get popMenage => _popMenage;

  Site.fromSnapshot(DataSnapshot snapshot){
    _id = snapshot.key;
    _nomSite = snapshot.value['nomSite'];
    _commune = snapshot.value['commune'];
    _departement = snapshot.value['departement'];
    _region = snapshot.value['region'];
    _lattitude = snapshot.value['lattitude'];
    _longitude = snapshot.value['longitude'];
    _etat = snapshot.value['etat'];
    _dateservie = snapshot.value['dateservie'];
    _lastdate = snapshot.value['lastdate'];
    _village = snapshot.value['village'];
    _typeOuvrage = snapshot.value['typeOuvrage'];
    _sysLavMain = snapshot.value['sysLavMain'];
    _popMenage = snapshot.value['popMenage'];
  }
}