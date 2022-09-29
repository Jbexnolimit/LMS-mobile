import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => StartState();

}

class StartState extends State<SplashScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginScreen()
    ));
  }


  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: new Color(0xFF42A5F5),
                gradient: LinearGradient(colors: [(new  Color(0xFF42A5F5)), new Color(0xFF42A5F5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),
          ),
          Center(

            child: Container(
              child: Image.asset("images/new.gif"),

              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),

          Container(
            margin: EdgeInsets.only( top: 190),
            alignment: Alignment.center,
            child: Text(
              "L M S",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight:FontWeight.bold,
              ),
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            child: Image.asset("images/app_logoo.png" ,
              scale: 2.0,),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          )


        ],
      ),
    );
  }
}