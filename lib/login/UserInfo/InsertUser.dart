import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:trip_planner/home/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:trip_planner/home/newHome.dart';

User? loggedInUser;

class InsertUserInfo extends StatefulWidget {
  const InsertUserInfo({Key? key}) : super(key: key);

  @override
  _InsertUserInfoState createState() => _InsertUserInfoState();
}

class _InsertUserInfoState extends State<InsertUserInfo> {
  File? imageFile;
  late String _url;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  late String dob;
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _district = TextEditingController();
  bool showSpinner = false;

  _getFromGallery() async {
    FocusScope.of(context).unfocus();
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
    FocusScope.of(context).unfocus();
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

  _remove() {
    Navigator.pop(context);
    setState(() {
      imageFile = null;
    });
  }

  // uploadProfilePic() async {
  //   final fileName = imageFile!.path;
  //   final ref = FirebaseStorage.instance
  //       .ref()
  //       .child('userImages')
  //       .child(_firstName.text + " " + _lastName.text + '.jpg');
  //   await ref.putFile(imageFile!);
  //   String url = await ref.getDownloadURL();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loggedInUser = FirebaseAuth.instance.currentUser;
    print(loggedInUser!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue,
                    Colors.white,
                  ]),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue[50],
                          radius: 45,
                          backgroundImage: (imageFile != null)
                              ? Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
                                ).image
                              : Image.asset(
                                  "assets/icon_user.png",
                                  fit: BoxFit.cover,
                                ).image,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 70,
                      child: RawMaterialButton(
                          elevation: 10,
                          fillColor: Colors.blue[300],
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(10.0),
                          shape: CircleBorder(),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Choose option",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue[300],
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              _getFromCamera();
                                            },
                                            splashColor: Colors.blue[300],
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.camera,
                                                    color: Colors.blue[300],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Camera",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _getFromGallery();
                                            },
                                            splashColor: Colors.blue[300],
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.image,
                                                    color: Colors.blue[300],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Gallery",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _remove();
                                            },
                                            splashColor: Colors.blue[300],
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Remove",
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
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 8, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextFormField(
                      controller: _firstName,
                      style: TextStyle(color: Colors.blue[400]),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.person_add,
                          color: Colors.blue[400],
                        ),
                        hintText: "First Name",
                        hintStyle: TextStyle(
                          color: Colors.blue[400],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 8, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextFormField(
                      controller: _lastName,
                      style: TextStyle(color: Colors.blue[400]),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.person_add_alt_1,
                          color: Colors.blue[400],
                        ),
                        hintText: "Last Name",
                        hintStyle: TextStyle(
                          color: Colors.blue[400],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 8, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextFormField(
                      controller: _district,
                      style: TextStyle(color: Colors.blue[400]),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.location_on,
                          color: Colors.blue[400],
                        ),
                        hintText: "District",
                        hintStyle: TextStyle(
                          color: Colors.blue[400],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 8, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: DateTimePicker(
                      style: TextStyle(color: Colors.blue[400]),
                      initialValue: '',
                      firstDate: DateTime(1800),
                      lastDate: DateTime(2100),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.blue[400],
                        ),
                        hintText: "Date of Birth",
                        hintStyle: TextStyle(
                          color: Colors.blue[400],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          dob = val;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 100),
                  child: Container(
                    width: 250,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: FlatButton(
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        var firebaseUser = FirebaseAuth.instance.currentUser;
                        final String firstName = _firstName.text;
                        final String lastName = _lastName.text;
                        final String district = _district.text;
                        String url;
      
                        if (firstName.isEmpty &&
                            lastName.isEmpty &&
                            district.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Text(
                                        "Error occured",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.blue[300],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Icon(Icons.warning_rounded,
                                            color: Colors.red),
                                      )
                                    ],
                                  ),
                                  content: Text("Please fill all field!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK"))
                                  ],
                                );
                              });
                        } else {
                          FirebaseFirestore.instance
                              .collection('userInformation')
                              .doc(firebaseUser!.uid)
                              .set({
                            "firstName": firstName,
                            "lastName": lastName,
                            "email": firebaseUser.email,
                            "district": district,
                            "dob": dob,
                          });
      
                          if (imageFile != null) {
                            final ref = FirebaseStorage.instance
                                .ref()
                                .child('userImages')
                                .child(firebaseUser.email! + '.jpg');
                            await ref.putFile(imageFile!);
                            url = await ref.getDownloadURL();
      
                            FirebaseFirestore.instance
                                .collection('userInformation')
                                .doc(firebaseUser.uid)
                                .update({
                              "imageURL": url,
                            });
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewHomeScreen()));
                        }
                        showSpinner = false;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 60),
                            child: Text(
                              "NEXT",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_alt,
                            size: 30,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
