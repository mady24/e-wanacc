import 'package:e_wanacc/onboarding/assets.dart';
import 'package:e_wanacc/onboarding/circle_image.dart';
import 'package:flutter/material.dart';

const double IMAGE_SIZE = 300.0;

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          /*new Positioned(
            child: new CircleWithImage(Assets.pose3),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),*/
          new Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: Image(
                    image: AssetImage(Assets.pose3),
                    fit: BoxFit.fitHeight,
                  ),
                  height: 100.0,
                  width: 150.0,
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Accéder à la géolocalisation des différents sites en temps réel',
                    style: Theme.of(context).textTheme.display1.copyWith(color: Colors.black, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        ],
        alignment: FractionalOffset.center,
      ),
    );
  }
}