import 'package:flutter/material.dart';

class NextPageRoute extends MaterialPageRoute {
  final Widget _whichScreen;

  NextPageRoute(this._whichScreen)
      : super(
            builder: (BuildContext context) => _whichScreen,
            maintainState: true);

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return  FadeTransition(opacity: animation, child: _whichScreen);
  }
}
