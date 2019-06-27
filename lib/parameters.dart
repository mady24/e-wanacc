import 'package:flutter/material.dart';


class Parameters extends StatefulWidget{
  @override
  _Parameters createState() => _Parameters();
}

class _Parameters extends State<Parameters>{

  String dropdownValue = 'Français';

  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  void _onChanged1(bool value) => setState(() => _value1 = value);
  void _onChanged2(bool value) => setState(() => _value2 = value);
  void _onChanged3(bool value) => setState(() => _value3 = value);

  double _sliderValue = 10.0;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Text('Langue d\'affichage'),
               Divider(
                      color: Colors.black,
                      height: 10,
                    ),
              DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['Français', 'English']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Divider(
                      color: Colors.black,
                      height: 10,
                    ),
              Text('Notifications'),
               Divider(
                      color: Colors.black,
                      height: 10,
                    ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                  Text('Activer les notifications'),
                  Switch(
                    onChanged: _onChanged1, 
                    value: _value1,
                  )
               ],
             ),
             Divider(
                      color: Colors.grey,
                      height: 10,
                    ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                  Text('Vibreur'),
                  Switch(
                    onChanged: _onChanged2, 
                    value: _value2,
                  )
               ],
             ),
            Divider(
                      color: Colors.grey,
                      height: 10,
                    ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                  Text('Sonore'),
                  Switch(
                    onChanged: _onChanged3, 
                    value: _value3,
                  )
               ],
             ),
             Divider(
                      color: Colors.grey,
                      height: 10,
                    ),
           
                  Text('Volume'),
                  Slider(
                    activeColor: Colors.indigoAccent,
                    min: 0.0,
                    max: 15.0,
                    onChanged: (newRating) {
                    setState(() => _sliderValue = newRating);
                    }, 
                    value: _sliderValue,
                  ),
             Divider(
                      color: Colors.black,
                      height: 10,
                    ),
            Text('Compte et réinitialisation'),
            Divider(
              color: Colors.black,
              height: 10.0,
            ),
            GestureDetector(
              onDoubleTap: () => {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                child:Text('Mon compte'),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 10.0,
            ),
            GestureDetector(
              onTap: () => {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                child:Text('Réinitialiser l\'application'),
              ),
            ),
            Divider(
              color: Colors.black,
              height: 10.0,
            ),
            Text('Mention légal et aide'),
             Divider(
              color: Colors.black,
              height: 10.0,
            ),
            GestureDetector(
              onDoubleTap: () => {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                child:Text('Mention légal'),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 10.0,
            ),
            GestureDetector(
              onTap: () => {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                child:Text('Aide'),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 10.0,
            ),
            ],
          ),
        ],
      ),
    );
  }
}