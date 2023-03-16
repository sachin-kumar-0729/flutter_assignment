import 'package:flutter/material.dart';


class ProgressHud extends StatefulWidget {
  final bool? isLoading;
  final Color color;
  final Widget? child;

  ProgressHud({this.isLoading, this.child, this.color = Colors.white38});

  @override
  _ProgressHudState createState() => _ProgressHudState();
}

class _ProgressHudState extends State<ProgressHud> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: widget.child,
          ),
          Visibility(
            visible: widget.isLoading!,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: widget.color,
              child: Center(
                child: Container(
                  width: 100,
                  height: 105,
                  decoration: const BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "Loading...",
                      ),
                      CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
