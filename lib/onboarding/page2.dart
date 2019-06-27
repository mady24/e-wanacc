import 'package:e_wanacc/onboarding/assets.dart';
import 'package:e_wanacc/onboarding/circle_image.dart';
import 'package:flutter/material.dart';

const double IMAGE_SIZE = 200.0;

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          /*new Positioned(
            child: new CircleWithImage(Assets.pose2),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),*/
          new Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: Image(
                    image: AssetImage(Assets.pose2),
                    fit: BoxFit.fitHeight,
                  ),
                  height: IMAGE_SIZE,
                  width: IMAGE_SIZE,
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