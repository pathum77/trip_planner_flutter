import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/home/home.dart';
import 'package:trip_planner/home/joinned/userInfoEdit.dart';
import 'package:trip_planner/home/newHome.dart';
import 'package:trip_planner/login/UserInfo/editUserInfo.dart';
import 'package:trip_planner/login/welcome.dart';

class UserInformationFloating extends StatefulWidget {
  const UserInformationFloating({Key? key}) : super(key: key);

 
  @override
  _UserInformationFloatingState createState() =>
      _UserInformationFloatingState();
}

class _UserInformationFloatingState extends State<UserInformationFloating> {
  
 final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String dob = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String district = '';
  String imageURL = '';

  alertDialogDelete(BuildContext context){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.warning_rounded,
              color:Colors.red
              ),
            ),
            Text("warning!"),
          ],
        ),
        content: Text("Are you sure want to remove your account?\nThis will erase your all data such as your PLANED TRIP, JOINED TRIP INFORMATION!!!"),
                                  actions: [
                                    MaterialButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("CANCEL"),
                                      ),
                                      MaterialButton(
                                      onPressed: () async {
                                       await FirebaseFirestore.instance.collection('userInformation').doc(FirebaseAuth.instance.currentUser!.uid).delete();
                                       
                                       var result = await FirebaseFirestore.instance
      .collection("participant")
      .where("participantMail", isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get()
      .then((value){ value.docs
      .forEach((element) { FirebaseFirestore.instance
      .collection("participant")
      .doc(element.id)
      .delete()
      .then((value){ print("Success!"); 
            }); 
          }); 
        });
                                       Navigator.push(
                                      context,
                                      MaterialPageRoute(
                builder: (context) => WelcomeScreen()));
                                      },
                                      child: Text("DELETE"),
                                      )
                                  ],
      );
    });
  }

  void _getdata() async {
  User? user = _firebaseAuth.currentUser;
  FirebaseFirestore.instance
    .collection('userInformation')
    .doc(user!.uid)
    .snapshots()
    .listen((userData) {
 
    setState(() {
      firstName = userData.data()!['firstName'];
      lastName  = userData.data()!['lastName'];
      district  = userData.data()!['district']; 
      email = userData.data()!['email'];
      dob = userData.data()!["dob"];
      //imageURL = userData.data()!["imageURL"];
    });
    });

    FirebaseFirestore.instance
    .collection('userInformation')
    .doc(user.uid)
    .snapshots()
    .listen((userData) {
 
    setState(() {
      imageURL = userData.data()!["imageURL"];
    });
    });
    }

    @override
  void initState() {
super.initState();
 _getdata();
 
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButton: null,


      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
      
                          IconButton(
                              //alignment: Alignment.center,
                              onPressed: (){
                                Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) =>
                          NewHomeScreen())); 
                              }, 
                              icon: Icon(Icons.arrow_back,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.1,
                              ),
                              ),
      
                          Text("PROFILE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                          ),

                             IconButton(
                              alignment: Alignment.topRight,
                              onPressed: (){
                                Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) =>
                          NewUserInfoEdit())); 
                              }, 
                              icon: Icon(Icons.edit,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.1,
                              ),
                              ),
                        ],
                      ),
      
                      
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(MediaQuery.of(context).size.width * 0.1), 
                          bottomLeft: Radius.circular(MediaQuery.of(context).size.width * 0.1),
                          ),
                        color: Colors.blue,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.29,
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue[50],
                        radius: 45,
                        backgroundImage: imageURL.isNotEmpty
                                         ? NetworkImage(imageURL,
                                         )
                                         : Image.asset(
                                "assets/icon_user.png",
                                fit: BoxFit.cover,
                              ).image,
                      ),
                    ),
                              ),
                            Container(child: Text(email,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width * 0.05
                            ),
                            )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("First Name "),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(firstName),
                      ),
                    ],
                  ),
      
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.06,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Last Name "),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(lastName),
                      ),
                    ],
                  ),
                  
                ),
              ),
      
              SizedBox(height: MediaQuery.of(context).size.width * 0.06,),
      
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("District "),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(district),
                      ),
                    ],
                  ),
                  
                ),
              ),
      
              SizedBox(height: MediaQuery.of(context).size.width * 0.06,),
      
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Date of Birth "),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(dob),
                      ),
                    ],
                  ),
                  
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.20,),
            ],
          ),
      ),
    //   floatingActionButton: new FloatingActionButton(
    //   elevation: 0.0,
    //   child: new Icon(Icons.delete),
    //   backgroundColor: new Color(0xFFE57373),
    //   onPressed: () async {
    //     //alertDialogDelete(context);
    //   }
    // )
    );
  }
}

