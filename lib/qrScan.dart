import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:e_wanacc/siteDetailsScan.dart';
import 'package:e_wanacc/site.dart';


class QrScan extends StatefulWidget{
  @override
  _QrScan createState() => _QrScan();
}
class _QrScan extends State<QrScan>{
  String qr;
  var test;
  var site;
  List<Site> items;
  StreamSubscription<Event> _onSiteAddedSubscription;
  bool camState = false;
  onPressed(String routeName) {
      Navigator.of(context).pushNamed(routeName);
    }
    @override
  void dispose(){
    _onSiteAddedSubscription.cancel();
    super.dispose();
  }

  Future<Site> getSite(String siteKey) async{
    Completer<Site> completer = new Completer<Site>();

     FirebaseDatabase.instance.reference().child('site').child(siteKey).once().then((DataSnapshot snapshot){
      site = new Site.fromSnapshot(snapshot);
    });

    return completer.future;

  }

  @override
  initState() {
    setState(() {
    });
    super.initState();
  }
  Map<dynamic, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Plugin example app'),
      ),
      body: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
            child: camState
                    ? new Center(
                        child: new SizedBox(
                          height: 400.0,
                          child: new QrCamera(
                            onError: (context, error) => Text(
                                  error.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                            qrCodeCallback: (code) {
                              setState(() {
                                qr = code;
                                //items = new List();
                                
                                
                              });
                              //site = getSite(code);
                             

                                FirebaseDatabase.instance.reference().child('site').child(code).once().then((DataSnapshot snapshot){
                                      site = new Site.fromSnapshot(snapshot);
                                });

                               

                              print('$code $site');
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SiteEdit(site)),
                              );
                            },
                            child: new Container(
                              
                            ),
                          ),
                        ),
                      )
                     : new Center(child: new Text("Camera inactive"))),
                    site == null? Text('nla'):Text('${site.nomSite}')
          ],
        ),
      ),

      floatingActionButton: new FloatingActionButton(
          child: new Text(
            "press me",
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            setState(() {
              camState = !camState;
            });
          }),
    );
  }
}