import 'package:flutter/material.dart';

class Laucher extends StatefulWidget{
  @override
  _Laucher createState() => _Laucher();
}

class _Laucher extends State<Laucher>{

  onPressed(String routeName) {
      Navigator.of(context).pushNamed(routeName);
    }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: Container(
      color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
            child: Image.asset('assets/logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
            child: Text('APPLICATION DE GEOLOCALISATION ET DE GESTION ', style: TextStyle(fontSize: 32.0, fontFamily: 'Cambria'), textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0,vertical: 40.0),
              child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                          
                        child: Padding( 
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: new Material(
                          child: MaterialButton(
                            child: Row(children: <Widget>[
                        Icon(Icons.exit_to_app),Text('Entrer', style: TextStyle(fontFamily: 'Cambria')),
                      ],),
                            onPressed: () => onPressed('/walktrough'),
                            highlightColor: Colors.white.withOpacity(0.5),
                            splashColor: Colors.white.withOpacity(0.5),
                          ),
                          color: Colors.transparent,
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}