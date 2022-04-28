import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/home/UserInfo.dart';
import 'package:intl/intl.dart';

class UserInfoEdit extends StatefulWidget {
  const UserInfoEdit({ Key? key }) : super(key: key);

  @override
  _UserInfoEditState createState() => _UserInfoEditState();
}

class _UserInfoEditState extends State<UserInfoEdit> {

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
TextEditingController _dob = TextEditingController();
TextEditingController _firstName = TextEditingController();
TextEditingController _lastName = TextEditingController();
TextEditingController _district = TextEditingController();
  String dob = '';
  String firstName = '';
  String lastName = '';
  String district = '';
  late DateTime selectedDate;

  void _getdata() async {
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

    @override
  void initState() {
super.initState();
 _getdata();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.95,
                                      decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white38,
                                  ),
                                  
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            
                                            Padding(padding: EdgeInsets.only(top: 20)),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  onChanged: (value){
                                                    setState(() {
                                                      firstName = value;
                                                    });
                                                  },
                                                  controller: _firstName,
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
                                                onChanged: (value){
                                                  setState(() {
                                                    lastName = value;
                                                  });
                                                },
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
                                                onChanged: (value){
                                                  setState(() {
                                                    district = value;
                                                  });
                                                },
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
                                             
                                             child: Row(
                                               children: [
                                                 Container(
                                                   width: MediaQuery.of(context).size.width * 0.7,
                                                  alignment: Alignment.bottomCenter,
                                               
                                                  child: TextFormField(
                                                    onChanged: (value){
                                                      setState(() {
                                                        dob = value;
                                                      });
                                                },
                                                    controller: _dob,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      border: OutlineInputBorder(),
                                                      labelText: "Date of Birth",
                                                    ),
                                                  ),
                                                  
                                            ),
                                            SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                                            IconButton(
                                             onPressed: (){
                                                selectDate(context);
                                              }, 
                                              icon: Icon(Icons.calendar_today_sharp,
                                              size: MediaQuery.of(context).size.width * 0.10,
                                              color: Colors.blue,
                                              ),
                                             )
                                               ],
                                             ),
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
                                                    onPressed: () async{
                                                       await FirebaseFirestore.instance
                                                      .collection('userInformation')
                                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                                      .update({
                                                      "firstName": _firstName.text,
                                                      "lastName": _lastName.text,
                                                      "district": _district.text,
                                                      "dob": _dob.text,
                                                      });
                                                      Navigator.push(
                                                          context, MaterialPageRoute(
                                                          builder: (context) => UserInformationFloating()));

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