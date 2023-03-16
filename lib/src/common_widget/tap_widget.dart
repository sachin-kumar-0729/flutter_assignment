import 'package:flutter/material.dart';

class TapWidget extends StatelessWidget {
  final Function()? onTap;
  final Widget? child;

   const TapWidget({Key? key, required this.onTap, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: child,
    );
  }
}
