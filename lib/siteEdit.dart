import 'dart:async';

import 'package:flutter/material.dart';
import 'package:e_wanacc/site.dart';
import 'package:e_wanacc/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

class SiteEdit extends StatefulWidget{
  Site site;
  SiteEdit(this.site);
  @override 
  _SiteEdit createState() => _SiteEdit();
}

final sites = FirebaseDatabase.instance.reference().child('site');

class _SiteEdit extends State<SiteEdit>{
  TextEditingController _nomSiteController;
  TextEditingController _communeSiteController;
  TextEditingController _departementSiteController;
  TextEditingController _regionSiteController;
  TextEditingController _longSiteController;
  TextEditingController _latSiteController;
  TextEditingController _etatSiteController;
  TextEditingController _villageController;
  TextEditingController _typeOuvrageController;
  TextEditingController _sysLavMainContoller;
  TextEditingController _popMenageController;
  Position currentLocation;
  var _center,_center1;


  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void setlatLong(){
     setState(() {
      _longSiteController.text = _center1;
      _latSiteController.text = _center;
     });
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = currentLocation.latitude.toString();
      _center1 = currentLocation.longitude.toString();
    });
    print('center $_center');
  }

  @override
  void initState(){
    setState(() {
      getUserLocation();
      _nomSiteController = new TextEditingController(text: widget.site.nomSite);
      _communeSiteController = new TextEditingController(text: widget.site.commune);
      _departementSiteController = new TextEditingController(text: widget.site.departement);
      _regionSiteController = new TextEditingController(text: widget.site.region);
      _longSiteController = new TextEditingController(text: widget.site.longitude);
      _latSiteController = new TextEditingController(text: widget.site.lattitude);
      _etatSiteController = new TextEditingController(text: widget.site.etat);
      _villageController = new TextEditingController(text: widget.site.village);
      _typeOuvrageController = new TextEditingController(text: widget.site.typeOuvrage);
      _sysLavMainContoller = new TextEditingController(text: widget.site.sysLavMain);
      _popMenageController = new TextEditingController(text: widget.site.popMenage);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier infos un site', style: TextStyle(fontFamily: 'Cambria'),),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        scrollDirection: Axis.vertical,
        children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Nom', style: TextStyle(color: Colors.black, fontFamily: 'Cambria', fontSize: 20.0, fontWeight: FontWeight.w500),),
                Container(
                  decoration: BoxDecoration(
                    
                  ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                  child:TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: null,
                  controller: _nomSiteController,
                ),
                ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Village', style: TextStyle(color: Colors.grey, fontFamily: 'Cambria', fontSize: 20.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),),
                Container(
                  decoration: BoxDecoration(
                    
                  ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                  child:TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: null,
                  controller: _villageController,
                ),
                ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Type d\'ouvrage', style: TextStyle(color: Colors.grey, fontFamily: 'Cambria', fontSize: 20.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),),
                Container(
                  decoration: BoxDecoration(
                    
                  ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                  child:TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: null,
                  controller: _typeOuvrageController,
                ),
                ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('existence d\'un systeme de lavage des mains', style: TextStyle(color: Colors.grey, fontFamily: 'Cambria', fontSize: 20.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),),
                Container(
                  decoration: BoxDecoration(
                    
                  ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                  child:TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: null,
                  controller: _sysLavMainContoller,
                ),
                ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('population du menage', style: TextStyle(color: Colors.grey, fontFamily: 'Cambria', fontSize: 20.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),),
                Container(
                  decoration: BoxDecoration(
                    
                  ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                  child:TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: null,
                  controller: _popMenageController,
                ),
                ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Commune', style: TextStyle(color: Colors.black, fontFamily: 'Cambria', fontSize: 20.0, fontWeight: FontWeight.w500),),
                Container(
                  decoration: BoxDecoration(
                    
                  ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                  child:TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: null,
                  controller: _communeSiteController,
                ),
                ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Département', style: TextStyle(color: Colors.black, fontFamily: 'Cambria', fontSize: 20.0, fontWeight: FontWeight.w500),),
                Container(
                  decoration: BoxDecoration(
                    
                  ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                  child:TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: null,
                  controller: _departementSiteController,
                ),
                ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Région', style: TextStyle(color: Colors.black, fontFamily: 'Cambria', fontSize: 20.0, fontWeight: FontWeight.w500),),
                Container(
                  decoration: BoxDecoration(
                    
                  ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                  child:TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: null,
                  controller: _regionSiteController,
                ),
                ),
                ),
              ],
            ),
           Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
              Text("Coordonnées"),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Longitude', style: TextStyle(color: Colors.black, fontFamily: 'Cambria', fontSize: 20.0, fontWeight: FontWeight.w500),),
                Container(
                  width: 150.0,
                  decoration: BoxDecoration(
                    
                  ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 5.0),
                  child:TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: null,
                  controller: _longSiteController,
                ),
                ),
                ),
              ],
            ),
              Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('Lattitude', style: TextStyle(color: Colors.black, fontFamily: 'Cambria', fontSize: 20.0, fontWeight: FontWeight.w500),),
                Container(
                  width: 150.0,
                  decoration: BoxDecoration(
                    
                  ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 5.0),
                  child:TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: null,
                  controller: _latSiteController,
                ),
                ),
                ),
              ],
            ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
              child: Padding( 
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                          child: new Material(
                          child: MaterialButton(
                            child: Row(children: <Widget>[
                        Icon(FontAwesomeIcons.mapMarkerAlt),Text('ma localisation')
                      ],),
                            onPressed: setlatLong,
                            highlightColor: Colors.green.withOpacity(0.5),
                            splashColor: Colors.green.withOpacity(0.5),
                          ),
                          color: Colors.transparent,
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        ),
               )
            ],),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
              Text("Etat du site"),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
            ]),
            Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                  child:TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: null,
                  controller: _etatSiteController,
                ),
                ),
                
            SizedBox(height: 20.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                          
                        child: Padding( 
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                          child: new Material(
                          child: MaterialButton(
                            child: Row(children: <Widget>[
                        Icon(Icons.edit),Text('Modifier')
                      ],),
                            onPressed: () => {
                              sites.child(widget.site.id).set({
                    'nomSite': _nomSiteController.text,
                    'commune': _communeSiteController.text,
                    'departement': _departementSiteController.text,
                    'region': _regionSiteController.text,
                    'longitude': _longSiteController.text,
                    'lattitude': _latSiteController.text,
                    'etat': _etatSiteController.text
                  }).then((_) {
                    Navigator.pop(context);
                  })
                            },
                            highlightColor: Colors.green.withOpacity(0.5),
                            splashColor: Colors.green.withOpacity(0.5),
                          ),
                          color: Colors.transparent,
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        ),
                        ),
              ],
            ),
              Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                          color: Colors.red[200],
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                          
                        child: Padding( 
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                          child: new Material(
                          child: MaterialButton(
                            child: Row(children: <Widget>[
                        Icon(Icons.delete),Text('Annuler')
                      ],),
                            onPressed: () => {Navigator.pop(context)},
                            highlightColor: Colors.red.withOpacity(0.5),
                            splashColor: Colors.red.withOpacity(0.5),
                          ),
                          color: Colors.transparent,
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        ),
                        ),
              ],
            ),
            ]),
        ],
      ),
    );
  }
}