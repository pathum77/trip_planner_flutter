import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/home/newHome.dart';
import 'package:trip_planner/login/welcome.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
         splash: Image.asset(
           "assets/splashScreen.png",
         width: MediaQuery.of(context).size.width * 0.3,
         height: MediaQuery.of(context).size.height * 0.3,
         ),
         duration: 3000,
         splashTransition: SplashTransition.rotationTransition,
         backgroundColor: Colors.blue.shade400,
       nextScreen: FirebaseAuth.instance.currentUser == null ? WelcomeScreen() : NewHomeScreen()
       ),
    );
  }
}