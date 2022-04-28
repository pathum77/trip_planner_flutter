
import 'dart:io';
import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_planner/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_planner/home/newHome.dart';

User? loggedInUser;

class UserInformation extends StatefulWidget {
  const UserInformation({ Key? key }) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  
File? imageFile;

  @override
  void initState() {
    super.initState();
    loggedInUser = FirebaseAuth.instance.currentUser;
    print(loggedInUser!.email);
  }

  late String dab;
  TextEditingController _fistName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _district = TextEditingController();

  _getFromGallery() async {
    Navigator.pop(context);
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _getFromCamera() async {
    Navigator.pop(context);
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blue,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Text("Trip Planner",
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.06,
        ),
        ),
      ),
      
    body:  Center(
        child: Container(
             decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blue.shade100,
                          Colors.blue.shade200,
                          Colors.purple.shade100,
                        ]),
                  ),

                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                    child: Center(
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Stack(
                                      children: [
                                       Container(
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.end,
                                           children: [
                                             Container(
                                              width: MediaQuery.of(context).size.width * 0.95,
                                              decoration: BoxDecoration(
                                                                                 borderRadius: BorderRadius.circular(20),
                                                                                 color: Colors.white
                                                                            ),
                                                                            
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                                               
                                                    Padding(
                                                      padding: const EdgeInsets.only(top:20),
                                                      child: Stack(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                                                        child: CircleAvatar(
                                                          radius: 50,
                                                          backgroundColor: Colors.blue,
                                                            child: CircleAvatar(
                                                              backgroundColor: Colors.blue[50],
                                                              radius: 45,
                                                                backgroundImage: (imageFile != null) 
                                                                  ? Image.file(imageFile!, fit: BoxFit.cover,).image
                                                                  : Image.asset("assets/icon_user.png", fit: BoxFit.cover,).image,
                                                            ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 85,
                                                        left: 80,
                                                        child: RawMaterialButton(
                                                          elevation: 10,
                                                          fillColor: Colors.purple,
                                                          child: Icon(Icons.add_a_photo),
                                                          padding: EdgeInsets.all(10.0),
                                                          shape: CircleBorder(),
                                                          onPressed: (){
                                                            showDialog(context: context, builder: (BuildContext context){
                                                              return AlertDialog(
                                                                title: Text("Choose option",
                                                                  style: TextStyle(
                                                                    fontSize: 20,
                                                                    color: Colors.purple,
                                                                  ),
                                                                ),
                                                                content: SingleChildScrollView(
                                                                  child: ListBody(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: (){
                                                                         _getFromCamera();
                                                                        },
                                                                        splashColor: Colors.purpleAccent,
                                                                        child: Row(
                                                                          children: [
                                                                            Padding(
                                                                                 padding: const EdgeInsets.all(8.0),
                                                                                 child: Icon(Icons.camera,
                                                                                 color: Colors.purpleAccent,
                                                                                 ),
                                                                            ),
                                                                            Padding(
                                                                                 padding: const EdgeInsets.all(8.0),
                                                                                 child: Text("Camera",
                                                                                 style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                                                                 ),
                                                                                 ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap: (){
                                                                            _getFromGallery();
                                                                          },
                                                                        splashColor: Colors.purpleAccent,
                                                                        child: Row(
                                                                          children: [
                                                                            Padding(
                                                                                 padding: const EdgeInsets.all(8.0),
                                                                                 child: Icon(Icons.image,
                                                                                 color: Colors.purpleAccent,
                                                                                 ),
                                                                            ),
                                                                            Padding(
                                                                                 padding: const EdgeInsets.all(8.0),
                                                                                 child: Text("Gallery",
                                                                                 style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                                                                 ),
                                                                                 ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap: (){},
                                                                               
                                                                        splashColor: Colors.purpleAccent,
                                                                        child: Row(
                                                                          children: [
                                                                            Padding(
                                                                                 padding: const EdgeInsets.all(8.0),
                                                                                 child: Icon(Icons.remove_circle,
                                                                                 color: Colors.purpleAccent,
                                                                                 ),
                                                                            ),
                                                                            Padding(
                                                                                 padding: const EdgeInsets.all(8.0),
                                                                                 child: Text("Remove",
                                                                                 style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
                                                            });
                                                          }
                                                          ),
                                                          ),
                                                    ],
                                                  ),
                                                    ),
                                                                               
                                                    Padding(padding: EdgeInsets.only(top: 20)),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                        child: TextFormField(
                                                         
                                                          controller: _fistName,
                                                          style: TextStyle(
                                                            fontSize: MediaQuery.of(context).size.width * 0.05,
                                                          ),
                                                          decoration: InputDecoration(
                                                              border: OutlineInputBorder(),
                                                              labelText: "First Name",
                                                            ),
                                                        ),
                                                    ),
                                                    Padding(padding: EdgeInsets.all(8.0),
                                                      child: TextFormField(
                                                        controller: _lastName,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(context).size.width * 0.05,
                                                          ),
                                                          decoration: InputDecoration(
                                                              border: OutlineInputBorder(),
                                                              labelText: "Last Name",
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(padding: EdgeInsets.all(8.0),
                                                      child: TextFormField(
                                                        controller: _district,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(context).size.width * 0.05,
                                                          ),
                                                          decoration: InputDecoration(
                                                              border: OutlineInputBorder(),
                                                              labelText: "District",
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(padding: EdgeInsets.all(8.0),
                                                      
                                                     child: Container(
                                                      alignment: Alignment.bottomCenter,
                                                      child: DateTimePicker(
                                                        initialValue: '',
                                                        firstDate: DateTime(1800),
                                                        lastDate: DateTime(2100),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: "Date of Birth",
                                                        ),
                                                                               
                                                        onChanged: (val){
                                                          dab =  val;
                                                        },
                                                      ),
                                                    ),
                                                         // onSaved: (val) => print(val),
                                                        ),
                                                                               
                                                                               
                                                    
                                                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
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
                                                            onPressed: () {
                                                              
                                                              var firebaseUser = FirebaseAuth.instance.currentUser;
                                                              final String firstName = _fistName.text;
                                                              final String lastName = _lastName.text;
                                                              final String district = _district.text;
                                                              if( firstName.isEmpty || lastName.isEmpty || district.isEmpty){
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(content: Text('Empty'))
                                                                );
                                                              }else{
                                                                 FirebaseFirestore.instance.collection('userInformation').doc(firebaseUser!.uid).set(
                                                                  {
                                                                    "firstName": firstName,
                                                                    "lastName": lastName,
                                                                    "email": firebaseUser.email,
                                                                    "district": district,
                                                                    "dob": dab,
                                                                  }
                                                                );
                                                                 Navigator.push(
                                                                   context, MaterialPageRoute(
                                                                   builder: (context) => NewHomeScreen()));
                                                              }
                                                            },
                                                            child: Text(
                                                              "SAVE",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: MediaQuery.of(context)
                                                                        .size
                                                                        .width *
                                                                    0.03,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(padding: EdgeInsets.only(bottom: 20)),
                                                  ],
                                                ),
                                              ),
                                                                                 ),
                                           ],
                                         ),
                                       ),
                                      ]
                                    ),
                                  ),
                                //),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
          ),
      ),

    );
  }
}