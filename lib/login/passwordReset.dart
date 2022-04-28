import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_planner/login/login.dart';
import 'package:trip_planner/login/resetSent.dart';

class PassRes extends StatefulWidget {
  const PassRes({Key? key}) : super(key: key);

  @override
  _PassResState createState() => _PassResState();
}

class _PassResState extends State<PassRes> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  late String email;

  void validate() {
    _auth.sendPasswordResetEmail(email: email);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResetSent()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/logo.png",
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.00,
                          ),
                          // ignore: deprecated_member_use
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.59,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white38,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(25.0),
                              child: Center(
                                child: Form(
                                  key: formkey,
                                  // ignore: deprecated_member_use
                                  autovalidateMode: AutovalidateMode.always, // autovalidate: true,

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Password Reset",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.020,
                                        ),
                                      ),

                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onChanged: (value) {
                                          email = value;
                                        },
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          prefixIcon: Icon(Icons.email),
                                          labelText: "Email",
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "Required"),
                                          EmailValidator(
                                              errorText: "Not a Valid Email")
                                        ]),
                                      ),

                                      //),

                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.020,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.14,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1),
                                          // ignore: deprecated_member_use
                                          child: FlatButton(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 40),
                                            color: Colors.purple.shade900,
                                            onPressed: validate,
                                            child: Text(
                                              "SEND REQUEST",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.030,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Back to",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogIn()));
                                },
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                ),
                              ),
                            ],
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
      //),
    );
  }
}
