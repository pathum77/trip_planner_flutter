import 'package:flutter/material.dart';
import 'package:trip_planner/login/login.dart';

class ResetSent extends StatelessWidget {
  const ResetSent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
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

              height: MediaQuery.of(context).size.height,
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
                  //  if (!isKeyboard)
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/logo.png",
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          // ignore: deprecated_member_use
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            // height: MediaQuery.of(context).size.height * 0.59,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white38,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(25.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text("Please check your email to change the password",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    ),
                                    SizedBox(height: 100.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Back to"),
                                        TextButton(onPressed: (){
                                          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LogIn()));
                                        },
                                         child: Text("Log in"),),
                                      ],
                                    ),
                                  ],
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
              
            ),
          ],
        ),
      ),
    );
  }
}