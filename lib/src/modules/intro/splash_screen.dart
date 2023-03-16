import 'package:flutter/material.dart';
import 'package:flutter_application/src/common_widget/next_page_route.dart';
import 'package:flutter_application/src/modules/home/view/home_page.dart';
import 'package:flutter_application/src/utils/utility.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    waitFor(3).then((value) {
      Navigator.pushAndRemoveUntil(context, NextPageRoute(const HomePage()), (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: screenWidth(context),
        color: Colors.greenAccent,
        child: Center(
          child: Card(child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Welcome", style: TextStyle(fontSize: 25),),
          )),
        ),
      ),
    );
  }
}
