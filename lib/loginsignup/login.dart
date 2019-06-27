import 'package:flutter/material.dart';
import 'package:e_wanacc/loginsignup/connexion.dart';
import 'package:e_wanacc/loginsignup/authentication.dart';
import 'package:e_wanacc/dashboard.dart';


class Login extends StatefulWidget{
  Login({this.auth});

  final BaseAuth auth;

  @override
  _Login createState() => new _Login();
}

enum AuthStatus{
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _Login extends State<Login>{
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState(){
    super.initState();
    widget.auth.getCurrentUser().then((user){
      setState((){
        if(user != null){
          _userId = user?.uid;
        }
        authStatus = user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn(){
    widget.auth.getCurrentUser().then((user){
      setState((){
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void _onSignedOut(){
    setState((){
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }
  Widget _buildWaitingScreen(){
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    switch(authStatus){
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new Connexion(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if(_userId.length > 0 && _userId != null){
          return new Dashboard(
            userId: _userId,
            auth: widget.auth,
            onSignedOut: _onSignedOut,
          );
        }else return _buildWaitingScreen();
        break;
      default: return _buildWaitingScreen();
    }
  }
}