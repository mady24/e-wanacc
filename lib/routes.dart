import 'dart:core';

import 'package:flutter/material.dart';
import 'package:e_wanacc/dashboard.dart';
import 'package:e_wanacc/map.dart';
import 'package:e_wanacc/siteList.dart';
import 'package:e_wanacc/qrScan.dart';
import 'package:e_wanacc/parameters.dart';
import 'package:e_wanacc/onboarding/walktrough.dart';
import 'package:e_wanacc/laucher.dart';
import 'package:e_wanacc/loginsignup/login.dart';
import 'package:e_wanacc/loginsignup/authentication.dart';

class Routes{

  var routes = <String, WidgetBuilder>{
    "/walktrough": (BuildContext context) => new WalkthroughScreen(),
    "/login": (BuildContext context) => new Login(auth: new Auth()),
    "/dashboard": (BuildContext context) => new Dashboard(),
    "/map": (BuildContext context) => new Map(),
    "/list": (BuildContext context) => new SiteList(),
    "/scan": (BuildContext context) => new QrScan(),
    "/param": (BuildContext context) => new Parameters(),
  };

  Routes(){
    runApp(new MaterialApp(
      title: 'E-Wanacc',
      theme: ThemeData(
        primaryColor: Colors.grey[200],
      ),
      home: new Laucher(),
      routes: routes,
    ));
  }
}