import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_wanacc/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:e_wanacc/site.dart';
import 'package:e_wanacc/siteDetails.dart';


class SiteList extends StatefulWidget{

  @override
  _SiteList createState() => _SiteList();
}

final sites = FirebaseDatabase.instance.reference().child('site');

class _SiteList extends State<SiteList>{
  List<Site> items;
  StreamSubscription<Event> _onSiteAddedSubscription;

  @override
  void initState(){
    super.initState();

    items = new List();
    _onSiteAddedSubscription = sites.onChildAdded.listen(_onSiteAdded);
    new Timer.periodic(Duration(seconds: 5), (Timer t) => setState((){
      items = new List();
    _onSiteAddedSubscription = sites.onChildAdded.listen(_onSiteAdded);
    }));
  }

  @override
  void dispose(){
    _onSiteAddedSubscription.cancel();
    super.dispose();
  }

  void _onSiteAdded(Event event){
    setState(() {
     items.add(new Site.fromSnapshot(event.snapshot)); 
    });
  }
  onPressed(String routeName) {
      Navigator.of(context).pushNamed(routeName);
    }

    save(cle, value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        //final scanned = 42;
        prefs.setString(cle, value);
        print('saved $cle $value');
      }

    void _navigateToSite(BuildContext context, Site site) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SiteDetail(site)),
    );
  }

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text('List des sites', style: TextStyle(fontFamily: 'Cambria')),
      leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushNamed('/dashboard'),
        ),
    ),
    body: ListView.builder(
      shrinkWrap: true,
      
      itemCount: items.length,
      itemBuilder: (context, position){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child:Material(
    color: Colors.white,
    elevation: 7.0,
    shadowColor: Color(0x802196F3),
    borderRadius: BorderRadius.circular(24.0),
    child: GestureDetector(
      onTap: () =>  _navigateToSite(context, items[position]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text("${items[position].nomSite}", 
              style: TextStyle(color: Colors.grey, fontFamily: 'Cambria', fontSize: 20.0),),
            ),
            Row(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                          FontAwesomeIcons.mapMarkedAlt,
                          size: 20.0,
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('${items[position].lattitude}; ${items[position].longitude}', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0),)  )
                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                          FontAwesomeIcons.info,
                          size: 20.0,
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('infos', style: TextStyle(fontFamily: 'Cambria', fontSize: 15.0), textAlign: TextAlign.right,)  )
                  ],
                )
              ],
            )
          ],
        ),
      )
    ),
          ),
  );
      }
    )
    
    
  );
}

}