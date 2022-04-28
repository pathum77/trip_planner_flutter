import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:trip_planner/login/UserInfo/InsertUser.dart';
import 'package:trip_planner/login/userInfo.dart';

class EmailVerification extends StatefulWidget {
  final String mail;
  final String pass;
  const EmailVerification({ Key? key, required this.mail, required this.pass}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
GlobalKey<FormState> formkey = GlobalKey<FormState>();

bool showSpinner = false;
String errorMessage = '';
bool isVisible = false;
bool submitValid = false;
final _auth = FirebaseAuth.instance;

//final TextEditingController _emailController = TextEditingController();
late String email;
final TextEditingController _otpController = TextEditingController();

late EmailAuth emailAuth;


@override
  void initState() {
    super.initState();
    emailAuth = new EmailAuth(
      sessionName: "sample session",
    );
    //emailAuth.config(remoteServerConfiguration);
  }

  void verifyOtp()async{
    isVisible = false;
    FocusScope.of(context).unfocus();
    errorMessage = '';
    setState(() {
      showSpinner = true;
    });

    var result = emailAuth.validateOtp(recipientMail: widget.mail, userOtp: _otpController.value.text);
    
    // print(emailAuth.validateOtp(
    //     recipientMail: _emailController.value.text,
    //     userOtp: _otpController.value.text));
        if(result) {

          FocusScope.of(context).unfocus();
     isVisible = false;
     setState(() {});
    if (formkey.currentState!.validate()) {
      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: widget.mail, password: widget.pass);
        // ignore: unnecessary_null_comparison
        if (newUser != null) {

          //
          //
          Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => InsertUserInfo()));

                setState(() {
                  showSpinner = false;
                });
        }
        errorMessage = '';
      } on FirebaseAuthException catch (error) {
        
        isVisible = true;
        errorMessage = error.message!;

        if(errorMessage== "The email address is already in use by another account."){
          isVisible = true;
          errorMessage = "Email already taken";
          setState(() {
           showSpinner = false;
          });
        }
      }
    } else {
      print("not validated");
    }
          
          print("otp verified");
        }else{
          isVisible = true;
   errorMessage = "Not Verified";
   setState(() {
     showSpinner = false;
   });

          //print("not verified");
        }
  }

// void sendOTP()async{
//   FocusScope.of(context).unfocus();
//   errorMessage = '';
//  // EmailAuth.sessionName = "Test Session";
//  bool result = await emailAuth.sendOtp(
//    recipientMail: email, otpLength: 6);
//  if (result){
//    //print("otp sent");
//    isVisible = true;
//    errorMessage = "OTP sent";
//    setState(() {});
//  }else{
//    //print("not sent");
//    isVisible = true;
//    errorMessage = "OTP Not Sent";
//    setState(() {});
//  }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.blue.shade200,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
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
                                  child: Form(
                                   key: formkey,
                                    // ignore: deprecated_member_use
                                    autovalidateMode: AutovalidateMode.always, // autovalidate: true,
      
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "VERIFICATION",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                                        Container(
                                          //color: Colors.amber,
                                          child: Image.asset(
                                            "assets/email.png",
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            height: MediaQuery.of(context).size.height * 0.1,
                                            ),
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                                        Text("We sent verification code on your email id"),
                                        SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.020,
                                          ),
                                        ),
                                        // TextFormField(
                                        //   //controller: _emailController,
                                        //   keyboardType:
                                        //       TextInputType.emailAddress,
                                        //   onChanged: (value) {
                                        //     _email = value;
                                        //   },
                                        //   style: TextStyle(
                                        //     fontSize: MediaQuery.of(context)
                                        //             .size
                                        //             .width *
                                        //         0.04,
                                        //   ),
                                        //   decoration: InputDecoration(
                                        //     border: OutlineInputBorder(),
                                        //     prefixIcon: Icon(Icons.email),
                                        //     suffixIcon: TextButton(
                                        //       child: Text("Send OTP"),
                                        //       onPressed: () => sendOTP(),
                                        //     ),
                                        //     labelText: "Email",
                                        //   ),
                                        //   validator: MultiValidator([
                                        //     RequiredValidator(
                                        //         errorText: "Required"),
                                        //     EmailValidator(
                                        //         errorText: "Not a Valid Email")
                                        //   ]),
                                        // ),
      
                                        SizedBox(
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.020,
                                        ),
      
                                        TextFormField(
                                          controller: _otpController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                         
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Verification code",
                                          ),
                                         
                                        ),
                                        
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
                                              onPressed: ()=> verifyOtp(),
                                              child: Text(
                                                "VERIFY",
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