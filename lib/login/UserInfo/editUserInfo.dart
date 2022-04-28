import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:trip_planner/home/UserInfo.dart';

class NewUserInfoEdit extends StatefulWidget {
  const NewUserInfoEdit({Key? key}) : super(key: key);

  @override
  _NewUserInfoEditState createState() => _NewUserInfoEditState();
}

class _NewUserInfoEditState extends State<NewUserInfoEdit> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _dob = TextEditingController();
  late DateTime selectedDate;
  bool showSpinner = false;
  String dob = '';
  String imageURL = '';
  File? imageFile;

  // isNotChanging(){
  //   if(imageURL.isNotEmpty){
  //     return NetworkImage(imageURL);
  //   } else {
  //    return Image.asset("assets/icon_user.png",fit: BoxFit.cover,).image;
  //   }
  // }

  // isChanging(){
  //   if(imageFile ){
  //     return NetworkImage(imageURL);
  //   } else {
  //    return Image.asset("assets/icon_user.png",fit: BoxFit.cover,).image;
  //   }
  // }

  setProfilePic(){
    if(imageFile == null){
      if(imageURL.isNotEmpty){
         return NetworkImage(imageURL);
      } else {
        return Image.asset("assets/icon_user.png",fit: BoxFit.cover,).image;
      }
    } else {
      return Image.file(imageFile!,fit: BoxFit.cover,).image;
    }
  }

  void _getdata() {
    User? user = _firebaseAuth.currentUser;
    FirebaseFirestore.instance
        .collection('userInformation')
        .doc(user!.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        _firstName.text = userData.data()!['firstName'];
        _lastName.text = userData.data()!['lastName'];
        _district.text = userData.data()!['district'];
        selectedDate = DateTime.parse(userData.data()!['dob']);
        _dob.text = DateFormat('yyyy-MM-dd').format(selectedDate);
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

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        //_dob.text = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
        _dob.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  _getFromGallery() async {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 10,
    );
    if (pickedFile != null) {
      setState(() {
        imageURL = '';
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
      imageQuality: 10,
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
      imageURL = '';
    });
  }

  uploadProfilePic() async {
    final fileName = imageFile!.path;
    final ref = FirebaseStorage.instance
        .ref()
        .child('userImages')
        .child(_firstName.text + " " + _lastName.text + '.jpg');
    await ref.putFile(imageFile!);
    String url = await ref.getDownloadURL();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdata();
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
                          backgroundImage: setProfilePic(),
                          // imageURL.isNotEmpty
                          //     ? NetworkImage(
                          //         imageURL,
                          //       )
                          //     : Image.asset(
                          //         "assets/icon_user.png",
                          //         fit: BoxFit.cover,
                          //       ).image,
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
                    child: TextFormField(
                      readOnly: true,
                      controller: _dob,
                      style: TextStyle(color: Colors.blue[400]),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              selectDate(context);
                            },
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.blue,
                            )),
                        hintText: "Date of Birth",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 50, bottom: 100, right: 10),
                      child: Container(
                        width: 100,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: FlatButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_sharp,
                              color: Colors.blue,
                            )),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 50, bottom: 100, left: 10),
                      child: Container(
                        width: 150,
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
                            await FirebaseFirestore.instance
                                .collection('userInformation')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              "firstName": _firstName.text,
                              "lastName": _lastName.text,
                              "district": _district.text,
                              "dob": _dob.text,
                            });
      
                            if (imageFile != null) {
                              final ref = FirebaseStorage.instance
                                  .ref()
                                  .child('userImages')
                                  .child(
                                      FirebaseAuth.instance.currentUser!.email! +
                                          '.jpg');
                              await ref.putFile(imageFile!);
                              imageURL = await ref.getDownloadURL();
      
                              FirebaseFirestore.instance
                                  .collection('userInformation')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                "imageURL": imageURL,
                              });
                            }else if(imageURL == ''){
                              FirebaseFirestore.instance
                                  .collection('userInformation')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                "imageURL": '',
                              });
                            }

                            //////////////////////
                             var result = await FirebaseFirestore.instance
      .collection("participant")
      .where("participantMail", isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get()
      .then((value){ value.docs
      .forEach((element) { FirebaseFirestore.instance
      .collection("participant")
      .doc(element.id)
      .update({
        "firstName": _firstName.text,
        "lastName": _lastName.text,
      })
      .then((value){ print("Success!"); 
            }); 
          }); 
        });
                            
                            if(imageFile != null){
                              var result = await FirebaseFirestore.instance
      .collection("participant")
      .where("participantMail", isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get()
      .then((value){ value.docs
      .forEach((element) { FirebaseFirestore.instance
      .collection("participant")
      .doc(element.id)
      .update({
        "imageURL": imageURL,
      })
      .then((value){ print("Success!"); 
            }); 
          }); 
        });
                            } else if(imageURL == ''){
                              var result = await FirebaseFirestore.instance
      .collection("participant")
      .where("participantMail", isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get()
      .then((value){ value.docs
      .forEach((element) { FirebaseFirestore.instance
      .collection("participant")
      .doc(element.id)
      .update({
        "imageURL": '',
      })
      .then((value){ print("Success!"); 
            }); 
          }); 
        });
                            }
                            
                            
                            //////////////////////
                            
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserInformationFloating()));
                                        setState(() {
                              showSpinner = false;
                            });
                          },
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
