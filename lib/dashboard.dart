import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:e_wanacc/font_awesome_flutter.dart';
import 'package:e_wanacc/loginsignup/authentication.dart';


class Dashboard extends StatefulWidget{
  Dashboard({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard>{

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  onPressed(String routeName) {
      Navigator.of(context).pushNamed(routeName);
    }

Material myItems(IconData icon, String heading, int color, String page){
  return Material(
    color: Colors.white,
    elevation: 0.0,
    shadowColor: Color(0x802196F3),
    borderRadius: BorderRadius.circular(24.0),
    child: GestureDetector(
      onTap: () =>  onPressed(page),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(24.0),
                    child:Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.black,
                        size: 60.0
                      ),
                    ),
                  ),
                  Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(heading, 
                    style: TextStyle(
                      color: Colors.black,
                       fontSize: 20.0,
                    ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    ),
  );
}

Material myItem(IconData icon, String heading, int color, String page){
  return Material(
    color: Colors.blue[300],
    elevation: 14.0,
    shadowColor: Color(0x802196F3),
    borderRadius: BorderRadius.circular(24.0),
    child: GestureDetector(
      onTap: () =>  onPressed(page),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(24.0),
                    child:Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Color(color),
                        size: 30.0
                      ),
                    ),
                  ),
                  Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(heading, 
                    style: TextStyle(
                      color: new Color(color),
                       fontSize: 10.0,
                    ),
                    ),
                  ),
                ),
          ],
        ),
      )
    ),
  );
}

@override
Widget build(BuildContext context){
  return Scaffold(
    body: Container(
       color: Colors.white,
    child: Column(
      children: <Widget>[
      Container(
       
        constraints: BoxConstraints(
          maxHeight: 100.0,
          minHeight: 100.0
      ),
      child: Column(
        children: <Widget>[
         
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                 
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical:  25.0),
                    child: Image.asset('assets/logo.png', height: 50.0, width: 60.0,),
                    /*Text('E-wanacc',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cambria'
                    ),
                    ),*/
                  ),
                ),
              ],
            ),
        ],   
      ),
    ),
      Container(
        
        constraints: BoxConstraints(
          maxHeight: 360.0,
          minHeight: 150.0
      ),
        child: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 24.0,
        mainAxisSpacing:50.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          myItems(FontAwesomeIcons.camera, "Scanner", 0xff26eb3c, "/scan"),
          myItems(FontAwesomeIcons.list, "List des sites", 0xff26eb3c, "/list"),
          myItems(FontAwesomeIcons.mapMarkerAlt, "Map", 0xff26eb3c, "/map"),
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(2, 150.0),
        ],
      ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 80.0, 12.0, 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.circular(30.0),
                          border: Border.all(color: Colors.black, width: 1.0),
                        ),
                          
                        child: Padding( 
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                          child: new Material(
                          child: MaterialButton(
                            child: Row(children: <Widget>[
                        Icon(Icons.exit_to_app),Text('Déconnexion')
                      ],),
                            onPressed: () => _signOut(),
                            highlightColor: Colors.white.withOpacity(0.5),
                            splashColor: Colors.white.withOpacity(0.5),
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
  );
}

}