import 'package:e_wanacc/onboarding/dot.dart';
import 'package:flutter/material.dart';
import 'package:e_wanacc/onboarding/page1.dart';
import 'package:e_wanacc/onboarding/page2.dart';
import 'package:e_wanacc/onboarding/page3.dart';

class _WalkthroughScreen extends State<WalkthroughScreen> {
  final _controller = new PageController();
  List<Widget> _pages = [];
  String _link;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
    Page1(),
    Page2(),
    Page3(),
  ];
  _link = "/login";
  }

   onPressed(String routeName) {
      Navigator.of(context).pushNamed(routeName);
    }


  @override
  Widget build(BuildContext context) {
    //bool isDone = page == _pages.length - 1;
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Stack(
        children: <Widget>[
          new Positioned.fill(
            child: new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
              onPageChanged: (int p){
                setState(() {
                  page = p;
                });
              },
            ),
          ),
          
          new Positioned(
            bottom: 10.0,
            left: 0.0,
            right: 0.0,
            child: new SafeArea(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DotsIndicator(
                      controller: _controller,
                      itemCount: _pages.length,
                      onPageSelected: (int page) {
                        _controller.animateToPage(
                          page,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      /*new Container(
                        width: 150.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          gradient: new LinearGradient(
                            colors: [
                              Colors.orange[600],
                              Colors.orange[900],
                            ],
                            begin: Alignment(0.5, -1.0),
                            end: Alignment(0.5, 1.0)
                          ),
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        child: new Material(
                          child: MaterialButton(
                            child: Text('I\'M NEW',
                              style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                            ),
                            onPressed: () => onPressed(_link),
                            highlightColor: Colors.orange.withOpacity(0.5),
                            splashColor: Colors.orange.withOpacity(0.5),
                          ),
                          color: Colors.transparent,
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),*/
                      new Container(
                        width: 150.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(30.0),
                          border: Border.all(color: Colors.black, width: 1.0),
                          color: Colors.transparent,
                        ),
                        child: new Material(
                          child: MaterialButton(
                            child: Text('LOG IN',
                              style: Theme.of(context).textTheme.button.copyWith(color: Colors.black),
                            ),
                            onPressed: () => onPressed(_link),
                            highlightColor: Colors.white30,
                            splashColor: Colors.white30,
                          ),
                          color: Colors.transparent,
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

class WalkthroughScreen extends StatefulWidget {
  WalkthroughScreen({Key key, this.client}) : super(key: key);

  String client;

  @override
  _WalkthroughScreen createState() => new _WalkthroughScreen();
}