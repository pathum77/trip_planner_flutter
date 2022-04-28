import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/login/login.dart';
import 'package:trip_planner/login/newRegister.dart';
import 'package:trip_planner/login/register.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

 bool isConnected = false;
  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
      isConnected = (result != ConnectivityResult.none);
    });
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.purple.shade100,
                Colors.blue.shade300,
                Colors.blue.shade100,
              ]),
        ),
        child: StreamBuilder(
                stream: Connectivity().onConnectivityChanged,
                builder: (BuildContext context,
                AsyncSnapshot<ConnectivityResult> snapshot) {
                  // ignore: unnecessary_null_comparison
                  if(snapshot != null &&
                     snapshot.hasData &&
                     snapshot.data != ConnectivityResult.none) {
        // ignore: dead_code
        return Container(
          height: size.height,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Image.asset(
                    "assets/bottom1.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Image.asset(
                    "assets/bottom2.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Image.asset(
                    "assets/top1.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Image.asset(
                    "assets/top2.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      // ignore: deprecated_member_use
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.14,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 1),
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            color: Colors.purple.shade900,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogIn()));
                            },
                            child: Text(
                              "LOG IN",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.034,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.14,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 1),
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: Text(
                              "REGISTER",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.034,
                                color: Colors.purple.shade900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
                     }
                     else{
                       return Container(
                         child: Center(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(
                                 Icons.wifi_off,
                                 size: MediaQuery.of(context).size.width * 0.2,
                                 color: Colors.black,
                                 ),
                                 Text("Not Connected to the Internet",
                                 style: TextStyle(
                                   fontSize: MediaQuery.of(context).size.width * 0.05,
                                   fontWeight: FontWeight.bold,
                                 ),
                                 ),
                             ],
                           ),

                         ),
                           );
                     }
                }
        )
      ),
    );
  }
}
