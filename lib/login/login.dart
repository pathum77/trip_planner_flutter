import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_planner/home/home.dart';
import 'package:trip_planner/home/newHome.dart';
import 'package:trip_planner/login/passwordReset.dart';
import 'package:trip_planner/login/register.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:trip_planner/login/userInfo.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isVisible = false;
  bool showSpinner = false;
  String errorMessage = '';
  bool _isHiddenPassword = true;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  void validate() async {
    FocusScope.of(context).unfocus();
    isVisible = false;
    setState(() {
      showSpinner = true;
    });
    if (formkey.currentState!.validate()) {
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        // ignore: unnecessary_null_comparison
        if (user != null) {
          User? user = _firebaseAuth.currentUser;
          var colExist = await FirebaseFirestore.instance
              .collection('userInformation')
              .doc(user!.uid)
              .get();

          if (!colExist.exists) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserInformation()));
            setState(() {
              showSpinner = false;
            });
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewHomeScreen()));
            setState(() {
              showSpinner = false;
            });
          }
        }
        errorMessage = '';
      } on FirebaseAuthException catch (error) {
        isVisible = true;
        errorMessage = error.message!;
        setState(() {
          showSpinner = false;
        });

        if (errorMessage ==
            "There is no user record corresponding to this identifier. The user may have been deleted.") {
          isVisible = true;
          errorMessage = "Email address was incorrect!";
          setState(() {
            showSpinner = false;
          });
        } else if (errorMessage ==
            "The password is invalid or the user does not have a password.") {
          isVisible = true;
          errorMessage = "Password was incorect!";
          setState(() {
            showSpinner = false;
          });
        } else if (errorMessage ==
            "A network error (such as timeout, interrupted connection or unreachable host) has occurred.") {
          isVisible = true;
          errorMessage = "Network Error!";
          setState(() {
            showSpinner = false;
          });
        } else if (errorMessage ==
            "com.google.firebase.FirebaseException: An internal error has occurred. [ Read error:ssl=0xb8ef6118: I/O error during system call, Connection reset by peer ]") {
          isVisible = true;
          errorMessage = "Network Error!";
          setState(() {
            showSpinner = false;
          });

          // ignore: unnecessary_null_comparison
        } else if (errorMessage != null) {
          isVisible = true;
          errorMessage = "Account Dissabled!";
          setState(() {
            showSpinner = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          //reverse: true,
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
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),

                            Visibility(
                              visible: isVisible,
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.white54,
                                width: MediaQuery.of(context).size.width * 1,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.error_outline,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              color: Colors.red,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " " + errorMessage,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Log In",
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
                                          textInputAction: TextInputAction.next,
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
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.020,
                                          ),
                                          child: TextFormField(
                                            textInputAction: TextInputAction.done,
                                            obscureText: _isHiddenPassword,
                                            onChanged: (value) {
                                              password = value;
                                            },
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                            ),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              prefixIcon: Icon(Icons.lock),
                                              suffixIcon: InkWell(
                                                onTap: () {
                                                  _isHiddenPassword =
                                                      !_isHiddenPassword;
                                                  setState(() {});
                                                },
                                                child: Icon(_isHiddenPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off),
                                              ),
                                              labelText: "Password",
                                            ),
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText: "Required"),
                                              MinLengthValidator(6,
                                                  errorText:
                                                      "Should be at least 6 charactors"),
                                              MaxLengthValidator(12,
                                                  errorText:
                                                      "Sould be lower than 12 charactors"),
                                            ]),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.020,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                                "LOG IN",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.030,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PassRes()));
                                            },
                                            child: Text(
                                              "Forgot Password",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
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
                                  "Don't have an account?",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                  },
                                  child: Text(
                                    "Register",
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
      ),
    );
  }
}
