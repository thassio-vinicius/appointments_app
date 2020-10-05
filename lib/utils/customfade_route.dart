import 'package:flutter/material.dart';

class CustomFadeRoute<T> extends PageRoute<T> {
  CustomFadeRoute({@required this.child, @required this.routeName});
  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => null;

  final Widget child;
  final String routeName;

  @override
  RouteSettings get settings => RouteSettings(name: routeName);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 1000);
}
