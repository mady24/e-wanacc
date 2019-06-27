import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:e_wanacc/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:e_wanacc/site.dart';
import 'package:e_wanacc/siteEdit.dart';

class SiteDetail extends StatefulWidget{
  final Site site;
  SiteDetail(this.site);
  @override
  _SiteDetail createState() => _SiteDetail();
}

class _SiteDetail extends State<SiteDetail>{
  var site;
  Timer _timer;
  Completer<GoogleMapController> _controller = Completer();

  static LatLng _center;
  String y,x;
  var long,lat,long1,lat1;
  
  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

   onPressed(String routeName) {
      Navigator.of(context).pushNamed(routeName);
    }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed(){
    setState(() {
     _currentMapType = _currentMapType == MapType.normal
            ? MapType.satellite
            : MapType.normal; 
    });
  }

  final Set<Marker> _markers ={};

  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position){
    _lastMapPosition = position.target;
  }

  void _navigateToEditSite(BuildContext context, Site site) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SiteEdit(site)),
    );
  }

  @override
  void initState() {
        setState(() {
          site = widget.site;
          if(widget.site.longitude == ""){
            long = 0.0;
          }else{
          long = double.parse(widget.site.longitude);
          }
          if(widget.site.lattitude == ""){
            lat = 0.0;
          }else{
          lat = double.parse(widget.site.lattitude);
          }
          if(long < 0){ y = '°W'; long1 = long*-1;}else{y = '°E'; long1 = long;}
          if(lat < 0){ x = '°S'; lat1 = lat*-1;}else{x = '°N'; lat1 = lat;}
          _center = LatLng(lat, long);
       _markers.add(Marker(
       markerId: MarkerId('${widget.site.nomSite}'),
       //long = double.parse(),
       position: LatLng(lat, long),
       infoWindow: InfoWindow(
         title: '${widget.site.nomSite}',
         snippet: '5 Star Rating',
         ),
         icon: BitmapDescriptor.defaultMarker,
       )); 
    });
    new Timer.periodic(Duration(seconds: 5), (Timer t) => setState((){
      FirebaseDatabase.instance.reference().child('site').child(widget.site.id).once().then((DataSnapshot snapshot){
          site = new Site.fromSnapshot(snapshot);

          if(site.longitude == ""){
            long = 0.0;
          }else{
          long = double.parse(widget.site.longitude);
          }
          if(site.lattitude == ""){
            lat = 0.0;
          }else{
          lat = double.parse(widget.site.lattitude);
          }
          if(long < 0){ y = '°W'; long1 = long*-1;}else{y = '°E'; long1 = long;}
          if(lat < 0){ x = '°S'; lat1 = lat*-1;}else{x = '°N'; lat1 = lat;}
          _center = LatLng(lat, long);
       _markers.add(Marker(
       markerId: MarkerId('${site.nomSite}'),
       //long = double.parse(),
       position: LatLng(lat, long),
       infoWindow: InfoWindow(
         title: '${widget.site.nomSite}',
         snippet: '5 Star Rating',
         ),
         icon: BitmapDescriptor.defaultMarker,
       )); 
                                });

    }));
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail', style: TextStyle(fontFamily: 'Cambria'),),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            child: Stack(
        children: <Widget>[ 
       GoogleMap(
        onMapCreated: _onMapCreated,
        compassEnabled: true,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
        mapType: _currentMapType,
        markers: _markers,
        onCameraMove: _onCameraMove,
      ),
      Align(alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
            onPressed: _onMapTypeButtonPressed,
            backgroundColor: Colors.green,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            child:  Icon(FontAwesomeIcons.solidMap, size: 36.0,),
          ),
      ),
      ),
        ],
      ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                  children: <Widget>[
                    Text('Nom:', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0)),
                    Text('${site.nomSite}', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0, fontWeight: FontWeight.w600), textAlign: TextAlign.end,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                  children: <Widget>[
                    Text('Commune:', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0)),
                    Text('${site.commune}', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0, fontWeight: FontWeight.w600)),
                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                  children: <Widget>[
                    Text('Derpartement:', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0)),
                    Text('${site.departement}', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0, fontWeight: FontWeight.w600)),
                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                  children: <Widget>[
                    Text('Region:', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0)),
                    Text('${site.region}', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0, fontWeight: FontWeight.w600)),
                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                  children: <Widget>[
                    Text('Etat du site:', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0)),
                    Text('${site.etat}', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0, fontWeight: FontWeight.w600)),
                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                  children: <Widget>[
                    Text('Coordonees:', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0)),
                    Text('$lat1$x,$long1$y', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0, fontWeight: FontWeight.w600)),
                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            onPressed: () => _navigateToEditSite(context, widget.site),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}