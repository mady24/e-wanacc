import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:e_wanacc/font_awesome_flutter.dart';
import 'package:e_wanacc/site.dart';

class Map extends StatefulWidget{
  @override
  _Map createState() => _Map();
}

final sites = FirebaseDatabase.instance.reference().child('site');

class _Map extends State<Map>{
  List<Site> items;
  var len;
  Timer _timer;
  StreamSubscription<Event> _onSiteAddedSubscription;
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(14.669102, -17.4404787);

  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
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
  var pos = [['first',14.700,-17.4404787],['second',14.800,-17.4404787],['third',14.669108,-17.4404787],['fourth',14.500,-17.4404787],['fifth',14.400,-17.4404787]];
  double lat,long;
  @override
  void initState() {
    setState(() {
      items = new List();
    _onSiteAddedSubscription = sites.onChildAdded.listen((Event event){
      items.add(new Site.fromSnapshot(event.snapshot));
    });

    print('${items.length}');

    //initializing markers
     _timer = new Timer(const Duration(milliseconds: 400), (){
        setState(() {
    for(int i = 0; i < items.length; i++){
        if(items[i].longitude == ""){
            long = 0.0;
          }else{
          long = double.parse(items[i].longitude);
          }
          if(items[i].lattitude == ""){
            lat = 0.0;
          }else{
          lat = double.parse(items[i].lattitude);
          }
       _markers.add(Marker(
       markerId: MarkerId(items[i].nomSite),
       position: LatLng(lat, long),
       infoWindow: InfoWindow(
         title: items[i].nomSite,
         snippet: '5 Star Rating',
         ),
         icon: BitmapDescriptor.defaultMarker,
       )); 
        }
   
    });
     });
    });
    super.initState();
  }

  @override
  void dispose(){
    _onSiteAddedSubscription.cancel();
    super.dispose();
  }

  /*void _onAddMarkerButtonPressed(){
    setState(() {
     _markers.add(Marker(
       markerId: MarkerId(_lastMapPosition.toString()),
       position: _lastMapPosition,
       infoWindow: InfoWindow(
         title: 'Really cool place',
         snippet: '5 Star Rating',
         ),
         icon: BitmapDescriptor.defaultMarker,
       )); 
    });
  }*/

  @override
  Widget build(BuildContext context){
     for(int i = 0; i < items.length; i++){
        if(items[i].longitude == ""){
            long = 0.0;
          }else{
          long = double.parse(items[i].longitude);
          }
          if(items[i].lattitude == ""){
            lat = 0.0;
          }else{
          lat = double.parse(items[i].lattitude);
          }
       _markers.add(Marker(
       markerId: MarkerId(items[i].nomSite),
       position: LatLng(lat, long),
       infoWindow: InfoWindow(
         title: items[i].nomSite,
         snippet: '5 Star Rating',
         ),
         icon: BitmapDescriptor.defaultMarker,
       )); 
        }
    return Scaffold(
      appBar: AppBar(
        title: Text('Map', style: TextStyle(color: Colors.black, fontFamily: 'Cambria'),),
        backgroundColor: Colors.white,
      ),
      body:Stack(
        children: <Widget>[ 
       GoogleMap(
        onMapCreated: _onMapCreated,
        compassEnabled: true,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 6.0,
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
          
          
    );
  }
}