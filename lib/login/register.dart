import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:trip_planner/login/emailVerification.dart';
import 'package:trip_planner/login/login.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool showSpinner = false;
  bool isVisible = false; 
  bool _isHiddenPassword = true;
  // ignore: unused_field
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  String errorMessage = '';
  late EmailAuth emailAuth;

  @override
  void initState() {
    super.initState();

     emailAuth = new EmailAuth(
      sessionName: "TRIP PLANER",
    );
  }

  void validate() async {
    FocusScope.of(context).unfocus();
     isVisible = false;
     setState(() {
       showSpinner = true;
     });
    if (formkey.currentState!.validate()) {
      // try {
      //   final newUser = await _auth.createUserWithEmailAndPassword(
      //       email: email, password: password);
        // ignore: unnecessary_null_comparison
    //     if (newUser != null) {

          //
          bool result = await emailAuth.sendOtp(
   recipientMail: email, otpLength: 6);
 if (result){
   //print("otp sent");
   isVisible = true;
   errorMessage = "OTP sent";
   setState(() {
     showSpinner = false;
   });
 }else{
   //print("not sent");
   isVisible = true;
   errorMessage = "OTP Not Sent";
   setState(() {
     showSpinner = false;
   });
 }
          //

          Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => EmailVerification(mail: email, pass: password)));
        }
    //     errorMessage = '';
    //   } on FirebaseAuthException catch (error) {
        
    //     isVisible = true;
    //     errorMessage = error.message!;

    //     if(errorMessage== "The email address is already in use by another account."){
    //       isVisible = true;
    //       errorMessage = "Email already taken";
    //       setState(() {});
    //     }
    //   }
    // } else {
    //   print("not validated");
    // }
    
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
      
                            Visibility(
                              visible: isVisible,
                              
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.white54,
                                width: MediaQuery.of(context).size.width * 1,
                                height: MediaQuery.of(context).size.height * 0.1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.error_outline,
                                              size: MediaQuery.of(context).size.width * 0.05,
                                              color: Colors.red,
                                              ),
                                          ),
                                          TextSpan(
                                            text: " " + errorMessage,
                                            
                                            style: TextStyle(
                                              
                                              fontSize: MediaQuery.of(context).size.width * 0.05,
                                              color: Colors.red,
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //           alignment: Alignment.centerRight,
                                    //           child: InkWell(
                                    //             onTap: () {},
                                    //             child: Icon(Icons.cancel,
                                                
                                    //             size: MediaQuery.of(context).size.width * 0.05,
                                    //             color: Colors.red,
                                    //             ),
                                    //           ),
                                    //         ),
                                  ],
                                ),
                              ),
                              ),
      
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            // ignore: deprecated_member_use
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.6,
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
                                          "Register",
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
                                            
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.020,
                                          ),
                                          child: TextFormField(
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
      
                                        // Padding(
                                        //   padding: EdgeInsets.only(
                                        //     top: MediaQuery.of(context)
                                        //             .size
                                        //             .height *
                                        //         0.020,
                                        //   ),
                                        //   child: TextFormField(
                                        //     obscureText: _isHiddenPassword,
                                        //     style: TextStyle(
                                        //       fontSize: MediaQuery.of(context)
                                        //               .size
                                        //               .width *
                                        //           0.04,
                                        //     ),
                                        //     decoration: InputDecoration(
                                        //       border: OutlineInputBorder(),
                                        //       prefixIcon: Icon(Icons.lock),
                                        //       suffixIcon: InkWell(
                                        //         onTap: () {
                                        //           _isHiddenPassword =
                                        //               !_isHiddenPassword;
                                        //           setState(() {});
                                        //         },
                                        //         child: Icon(_isHiddenPassword
                                        //             ? Icons.visibility
                                        //             : Icons.visibility_off),
                                        //       ),
                                        //       labelText: "Confirm Password",
                                        //     ),
                                        //     validator: (value) { MatchValidator(errorText: "Password do not match").validateMatch(value!, password);}
                                        //   ),
                                        // ),
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
                                                "REGISTER",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.034,
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
                                  "Already have an account?",
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
                //),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
