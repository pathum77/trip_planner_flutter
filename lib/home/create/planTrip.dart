import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/home/created/PlannedTrip.dart';
import 'package:trip_planner/home/created/selectedPlannedTrip.dart';
import 'package:trip_planner/home/home.dart';
import 'package:trip_planner/home/newHome.dart';

class PlanTrip extends StatefulWidget {

  @override
  _PlanTripState createState() => _PlanTripState();
}

class _PlanTripState extends State<PlanTrip> {

  createAlertDialog(BuildContext context){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Add Destination"),
        content: TextFormField(       
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    onChanged: (value) {
                                      _destination = value;
                                    },
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                    ),
                                    decoration: InputDecoration(
                                      // suffixIcon: IconButton(onPressed: (){
                                      //   setState(() {
                                      //     item.add(_destination);
                                      //   });
                                      // },
                                      // icon: Icon(Icons.add_circle)),
                                      //border: OutlineInputBorder(),
                                      labelText: "Destination",
                                    ),
                                  ),
                                  actions: [
                                    MaterialButton(
                                      onPressed: (){
                                        setState(() {
                                          item.add(_destination);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("ADD"),
                                      )
                                  ],
      );
    });
  }

int currentStep = 0;

  var docId = FirebaseFirestore.instance.collection("planTrip").doc();
  List<String> item = [];
  List<String> admin = [];
  var firebaseUser = FirebaseAuth.instance.currentUser;
  int adults= 0;
  int teens= 0;
  int kids= 0;
  late String _destination = '';
  late TimeOfDay time;
  late TimeOfDay startPicked;
  late TimeOfDay endPicked;
  late String start;
  late String _startDate;
  late String _endDate;
  late String _startTime;
  late String _endTime;
  bool checkNextStep = false;
  TextEditingController _description = TextEditingController();
  TextEditingController _startTimeCtrl = TextEditingController();
  TextEditingController _endTimeCtrl = TextEditingController();
  TextEditingController adultValue = TextEditingController();
  TextEditingController teenValue = TextEditingController();
  TextEditingController kidValue = TextEditingController();

  List<Step> getSteps()=>[
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: Text("step 1"), 
      content: Container(
        child: Column(
          children: [
            TextButton.icon(
              onPressed: (){
                createAlertDialog(context);
              }, 
              icon: Icon(Icons.add_location_alt), 
              label: Text("ADD DESTINATION(S)",
              style: TextStyle(
                fontSize: 20,
              ),
              ),
              ),
                                  ListView(
                                    shrinkWrap: true,
                                    children: 
                                      item.map((element) =>
                                      
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Icon(Icons.location_on,
                                          // color: Colors.red,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(element,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width * 0.05,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: (){
                                              setState(() {
                                                 int index =  item.indexOf(element);
                                                 item.removeAt(index);
                                              });
                                            }, 
                                          icon: Icon(Icons.remove_circle_outline,
                                          color: Colors.red,),
                                          )
                                        ],
                                      )
                                      )
                                      .toList(),
                                  ),
          ],
          
        ),
      )
    ),
    Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      title: Text("step 2"), 
      content: Container(
        child: Column(
          children: [
            
             Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(" Start",
                                          ),
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.bottomCenter,
                                              width:
                                                  MediaQuery.of(context).size.width *
                                                      0.4,
                                              child: DateTimePicker(
                                                initialValue: '',
                                                firstDate: DateTime(2021),
                                                lastDate: DateTime(2100),
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Start Date",
                                                ),

                                                onChanged: (val){
                                                  _startDate =  val;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  MediaQuery.of(context).size.width *
                                                      0.05,
                                            ),
                                            Container(
                                              alignment: Alignment.bottomCenter,
                                              width:
                                                  MediaQuery.of(context).size.width *
                                                      0.4,
                                              child: TextFormField(
                                                controller: _startTimeCtrl,
                                                 readOnly: true,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Start Time",
                                                ),
                                                onTap: () async {
                                                  
    startPicked = (await showTimePicker(context: context, initialTime: time))!;

    _startTime = startPicked.format(context);
    _startTimeCtrl.text = _startTime;
    setState(() {
      FocusScope.of(context).unfocus();
    });
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'cant be empty';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                      /////////////////////////////////////////
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                      Padding(
                                  padding: EdgeInsets.all(0),
                                  

                                child: Container(
                                    color: Colors.white60,
                                    height: MediaQuery.of(context).size.height * 0.14,
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(" End",
                                          ),
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.bottomCenter,
                                              width:
                                                  MediaQuery.of(context).size.width *
                                                      0.4,
                                              child: DateTimePicker(
                                                initialValue: '',
                                                firstDate: DateTime(2021),
                                                lastDate: DateTime(2100),
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "End Date",
                                                ),

                                                onChanged: (val){
                                                  _endDate =  val;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  MediaQuery.of(context).size.width *
                                                      0.05,
                                            ),
                                            Container(
                                              alignment: Alignment.bottomCenter,
                                              width:
                                                  MediaQuery.of(context).size.width *
                                                      0.4,
                                              child: TextFormField(
                                                controller: _endTimeCtrl, 
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "End Time",
                                                ),
                                                onTap: () async {
                                                 
                                                  endPicked = (await showTimePicker(context: context, initialTime: time))!;
                                                  _endTime = endPicked.format(context);
                                                  _endTimeCtrl.text = _endTime;
                                                  
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'cant be empty';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                      ],
                                    ),
                                  ),
                      ),
                      SizedBox(height: 20,),
                Container(
             child:Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: TextFormField(
                                        maxLines: null,
                                        //keyboardType: TextInputType.multiline,
                                        controller: _description,
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.width *
                                                  0.05,
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Description",
                                        ),
                                      ),
                                    ),
          ),
          ]
        ),
        ),
        ),
            
                                      
    Step(
      isActive: currentStep >= 2,
      title: Text("step 3"), 
      content: Column(
        children: [
          
          Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              //ADULTS START
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Adults : ",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                  ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                          if(adults <= 0){
                                            adults= 0;
                                          } else{
                                            adults--;
                                          }
                                        });
                                }, 
                                icon: Icon(Icons.remove,
                                ),
                                ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.13,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  textAlign: TextAlign.center,
                                  controller: adultValue,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                          adults++;
                                        });
                                }, 
                                icon: Icon(Icons.add)
                                ),
                            )
                          ],
                        ),
                      ),
                ],
              ),
              //ADULTS END
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              //TEEN START
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Teens : ",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                  ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                          if(teens <= 0){
                                            teens = 0;
                                          } else{
                                            teens--;
                                          }
                                        });
                                }, 
                                icon: Icon(Icons.remove,
                                ),
                                ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.13,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  textAlign: TextAlign.center,
                                  controller: teenValue,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                          teens++;
                                        });
                                }, 
                                icon: Icon(Icons.add)
                                ),
                            )
                          ],
                        ),
                      ),
                ],
              ),
              //TEEN END
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              //KID START
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Kids : ",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                  ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                          if(kids <= 0){
                                            kids = 0;
                                          } else{
                                            kids--;
                                          }
                                        });
                                }, 
                                icon: Icon(Icons.remove,
                                ),
                                ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.13,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  textAlign: TextAlign.center,
                                  controller: kidValue,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                          kids++;
                                        });
                                }, 
                                icon: Icon(Icons.add)
                                ),
                            )
                          ],
                        ),
                      ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            ]
          ),
        )
      )
        ],
      ),
    )
  ];

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String dob = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String district = '';
  String imageURL = '';

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
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
      imageURL = userData.data()!['imageURL'];

      // dob  = userData.data()!['dob'];
      // dob = dob.replaceAll("-", ",");
    });
    });
  }

  Future<Null> selectTime(BuildContext context) async {
    startPicked = (await showTimePicker(context: context, initialTime: time))!;

    // ignore: unnecessary_null_comparison
    if (startPicked != null) {
      setState(() {
        time = startPicked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    adultValue.text = adults.toString();
    teenValue.text = teens.toString();
    kidValue.text = kids.toString();
    checkNextStep = _destination.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.more_vert,
        //       size: MediaQuery.of(context).size.width * 0.06,
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
        title: Text(
          "Plan a Trip",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.06,
          ),
        ),
      ),


    body: Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(primary: Colors.blue),
      ),
      child: Stepper(
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () async{
                final isLastStep = currentStep == getSteps().length -1;
    
                if(isLastStep){
                  print('complete');
                  ////////////
                  var firebaseUser =
                                            FirebaseAuth.instance.currentUser;
                                        final List<String> destination = item.toList();
                                        final String startDate = _startDate;
                                        final String startTime = _startTime.toString();
                                        final String endDate = _endDate;
                                        final String endTime = _endTime.toString();
                                        final String description =
                                            _description.text;
                                            DateTime start = DateTime.parse(_startDate);
                                            DateTime end = DateTime.parse(_endDate);
                                        if (destination.isEmpty) {
                                          showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Icon(Icons.error,
                                                    color: Colors.red),
                                              ),
                                              Text(
                                                "Error!",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue[300],
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                              "Input fields can not be empty!"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("GOT IT")),
                                          ],
                                        );
                                      });
                                        } else {
                                          if(start.isBefore(end) == false){
                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Icon(Icons.error,
                                                    color: Colors.red),
                                              ),
                                              Text(
                                                "Error!",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue[300],
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                              "The start date can not be after to the end date!"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("GOT IT")),
                                          ],
                                        );
                                      });
                                      } else {
                                                      if(adultValue.text == '0' && teenValue.text == '0' && kidValue.text == '0') {
                                            showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Icon(Icons.error,
                                                    color: Colors.red),
                                              ),
                                              Text(
                                                "Error!",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue[300],
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                              "Input fields can not be empty!"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("GOT IT")),
                                          ],
                                        );
                                      });
                                          }else {
                                             //             else {
                                          DocumentReference docRef = FirebaseFirestore.instance.collection("planTrip").doc();
                                          docRef.set({
                                            "destination": destination,
                                            "startdate": startDate,
                                            "starttime": startTime,
                                            "enddate": endDate,
                                            "endtime": endTime,
                                            "description": description,
                                            "email": firebaseUser!.email,
                                            "id": docRef.id,
                                            "firstName": firstName,
                                            "lastName": lastName,
                                          });

                                          DocumentReference docRefbudjet = FirebaseFirestore.instance.collection("budget").doc(docRef.id);
                                          docRefbudjet.set({
                                            "food": "",
                                            "transport": "",
                                            "drinks": "",
                                            "accomondation": "",
                                            "others": "",
                                            "total": "0",
                                            "id": docRef.id
                                          });
                                          
                                          DocumentReference docRefParticipatant = FirebaseFirestore.instance.collection("participant").doc();
                                          docRefParticipatant.set({
                                            "participantMail": firebaseUser.email,
                                            "adults": adultValue.text,
                                            "teens": teenValue.text,
                                            "kids": kidValue.text,
                                            "tripId": docRef.id,
                                            "firstName": firstName,
                                            "lastName": lastName,
                                            "destination": destination,
                                            "startdate": startDate,
                                            "starttime": startTime,
                                            "imageURL": imageURL,
                                          });

                                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(Icons.check_circle_outline,
                                          color: Colors.lightGreen),
                                    ),
                                    Text(
                                      "SUCCESS",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue[300],
                                      ),
                                    ),
                                  ],
                                ),
                                content: Text("Trip Planned successfully!"),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                       
                                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewHomeScreen()));
                                      },
                                      child: Text("DASHBOARD")
                                      ),
                                  TextButton(
                                      onPressed: () async {
                                        
                                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PlannedTrip()));
                                      },
                                      child: Text("PLANNED TRIP")
                                      ),
                                ],
                              );
                            });   
                                        }
                                      }
                            
                                          }
                                        
                           
                }else{
                setState(() => currentStep += 1);
                }
              },
              onStepTapped: (step) => setState(() => currentStep = step),
              onStepCancel: 
                currentStep == 0 ? null: () => setState(() => currentStep -= 1),

                controlsBuilder: (BuildContext context, ControlsDetails controls){
                  final isLastStep = currentStep == getSteps().length -1;
                  
                  return Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        
                        Expanded(
                          child: ElevatedButton(
                            child: Text(isLastStep ? "CONFIRM" : "NEXT"),
                            onPressed: checkNextStep ? controls.onStepContinue : controls.onStepCancel,
                          ),
                          ),
                          const SizedBox(width: 12,),
                          if(currentStep !=0)
                          Expanded(
                          child: ElevatedButton(
                            child: Text("BACK"),
                            onPressed: controls.onStepCancel,
                          ),
                          ),
                      ],
                    ),
                  );
                },
            ),
    ),



      // body: Center(
      //   child: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //           begin: Alignment.topCenter,
      //           end: Alignment.bottomCenter,
      //           colors: [
      //             Colors.blue.shade100,
      //             Colors.blue.shade200,
      //             Colors.purple.shade100,
      //           ]),
      //     ),
      //     height: MediaQuery.of(context).size.height,
      //     width: double.infinity,
      //     child: Center(
      //       child: Container(
      //         child: SingleChildScrollView(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Center(
      //                   child: Container(
      //                     width: MediaQuery.of(context).size.width * 0.95,
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(20),
      //                       color: Colors.white38,
      //                     ),

    //                       child: Container(
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Padding(padding: EdgeInsets.only(top: 20)),
    //                             Padding(
    //                               padding: const EdgeInsets.all(8.0),
                                  
    //                               child: Column(
    //                                 children: [
    //                                   TextFormField(
                                    
    //                                 keyboardType: TextInputType.multiline,
    //                                 maxLines: null,
    //                                 onChanged: (value) {
    //                                   _destination = value;
    //                                 },
    //                                 style: TextStyle(
    //                                   fontSize:
    //                                       MediaQuery.of(context).size.width *
    //                                           0.05,
    //                                 ),
    //                                 decoration: InputDecoration(
    //                                   suffixIcon: IconButton(onPressed: (){
    //                                     setState(() {
    //                                       item.add(_destination);
    //                                     });
    //                                   },
    //                                   icon: Icon(Icons.add_circle)),
    //                                   border: OutlineInputBorder(),
    //                                   labelText: "Destination",
    //                                 ),
    //                               ),
    //                               ListView(
    //                                 shrinkWrap: true,
    //                                 children: 
    //                                   item.map((element) => Text(element)).toList(),
                                    
    //                               ),
    //                                 ],
    //                               ),

    //                             ),

    //                             Padding(
    //                               padding: EdgeInsets.all(8.0),
    //                               child: TextFormField(
    //                                 controller: _route,
    //                                 style: TextStyle(
    //                                   fontSize:
    //                                       MediaQuery.of(context).size.width *
    //                                           0.05,
    //                                 ),
    //                                 decoration: InputDecoration(
    //                                   border: OutlineInputBorder(),
    //                                   labelText: "Rout",
    //                                 ),
    //                               ),
    //                             ),
    //                             Padding(
    //                               padding: EdgeInsets.all(8.0),

    //                               child: Container(
    //                                 color: Colors.white60,
    //                                 height: MediaQuery.of(context).size.height * 0.14,
    //                                 child: Column(
    //                                   children: [
    //                                     Container(
    //                                       alignment: Alignment.topLeft,
    //                                       child: Text(" Start",
    //                                       ),
    //                                     ),
    //                                     SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
    //                                     Row(
    //                                       mainAxisAlignment: MainAxisAlignment.center,
    //                                       children: [
    //                                         Container(
    //                                           alignment: Alignment.bottomCenter,
    //                                           width:
    //                                               MediaQuery.of(context).size.width *
    //                                                   0.4,
    //                                           child: DateTimePicker(
    //                                             initialValue: '',
    //                                             firstDate: DateTime(2021),
    //                                             lastDate: DateTime(2100),
    //                                             decoration: InputDecoration(
    //                                               border: OutlineInputBorder(),
    //                                               labelText: "Start Date",
    //                                             ),

    //                                             onChanged: (val){
    //                                               _startDate =  val;
    //                                             },
    //                                           ),
    //                                         ),
    //                                         SizedBox(
    //                                           width:
    //                                               MediaQuery.of(context).size.width *
    //                                                   0.1,
    //                                         ),
    //                                         Container(
    //                                           alignment: Alignment.bottomCenter,
    //                                           width:
    //                                               MediaQuery.of(context).size.width *
    //                                                   0.4,
    //                                           child: TextFormField(
    //                                             controller: _startTimeCtrl,
                                                 
    //                                             decoration: InputDecoration(
    //                                               border: OutlineInputBorder(),
    //                                               labelText: "Start Time",
    //                                             ),
    //                                             onTap: () async {
                                                  
    // startPicked = (await showTimePicker(context: context, initialTime: time))!;

    // _startTime = startPicked.format(context);
    // _startTimeCtrl.text = _startTime; 
    //                                             },
    //                                             validator: (value) {
    //                                               if (value!.isEmpty) {
    //                                                 return 'cant be empty';
    //                                               }
    //                                               return null;
    //                                             },
    //                                           ),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                     SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                                   //endDate
    //                             Padding(
    //                               padding: EdgeInsets.all(8.0),

    //                             child: Container(
    //                                 color: Colors.white60,
    //                                 height: MediaQuery.of(context).size.height * 0.14,
    //                                 child: Column(
    //                                   children: [
    //                                     Container(
    //                                       alignment: Alignment.topLeft,
    //                                       child: Text(" End",
    //                                       ),
    //                                     ),
    //                                     SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
    //                                     Row(
    //                                       mainAxisAlignment: MainAxisAlignment.center,
    //                                       children: [
    //                                         Container(
    //                                           alignment: Alignment.bottomCenter,
    //                                           width:
    //                                               MediaQuery.of(context).size.width *
    //                                                   0.4,
    //                                           child: DateTimePicker(
    //                                             initialValue: '',
    //                                             firstDate: DateTime(2021),
    //                                             lastDate: DateTime(2100),
    //                                             decoration: InputDecoration(
    //                                               border: OutlineInputBorder(),
    //                                               labelText: "End Date",
    //                                             ),

    //                                             onChanged: (val){
    //                                               _endDate =  val;
    //                                             },
    //                                           ),
    //                                         ),
    //                                         SizedBox(
    //                                           width:
    //                                               MediaQuery.of(context).size.width *
    //                                                   0.1,
    //                                         ),
    //                                         Container(
    //                                           alignment: Alignment.bottomCenter,
    //                                           width:
    //                                               MediaQuery.of(context).size.width *
    //                                                   0.4,
    //                                           child: TextFormField(
    //                                             controller: _endTimeCtrl, 
                                                
    //                                             decoration: InputDecoration(
    //                                               border: OutlineInputBorder(),
    //                                               labelText: "End Time",
    //                                             ),
    //                                             onTap: () async {
                                                 
    //                                               endPicked = (await showTimePicker(context: context, initialTime: time))!;
    //                                               _endTime = endPicked.format(context);
    //                                               _endTimeCtrl.text = _endTime;
                                                  
    //                                             },
    //                                             validator: (value) {
    //                                               if (value!.isEmpty) {
    //                                                 return 'cant be empty';
    //                                               }
    //                                               return null;
    //                                             },
    //                                           ),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                     SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
    //                                   ],
    //                                 ),
    //                               ),
                                

    //                             ),

    //                             Padding(
    //                               padding: EdgeInsets.all(8.0),
    //                               child: TextFormField(
    //                                 controller: _description,
    //                                 style: TextStyle(
    //                                   fontSize:
    //                                       MediaQuery.of(context).size.width *
    //                                           0.05,
    //                                 ),
    //                                 decoration: InputDecoration(
    //                                   border: OutlineInputBorder(),
    //                                   labelText: "Description",
    //                                 ),
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               height:
    //                                   MediaQuery.of(context).size.height * 0.02,
    //                             ),
    //                             Container(
    //                               width:
    //                                   MediaQuery.of(context).size.width * 0.8,
    //                               height:
    //                                   MediaQuery.of(context).size.width * 0.14,
    //                               child: ClipRRect(
    //                                 borderRadius: BorderRadius.circular(
    //                                     MediaQuery.of(context).size.width * 1),
    //                                 // ignore: deprecated_member_use
    //                                 child: FlatButton(
    //                                   padding: EdgeInsets.symmetric(
    //                                       vertical: 20, horizontal: 40),
    //                                   color: Colors.purple.shade900,
    //                                   onPressed: () async{
    //                                     var firebaseUser =
    //                                         FirebaseAuth.instance.currentUser;
    //                                     final List<String> destination = item.toList();
    //                                     final String route = _route.text;
    //                                     final String startDate = _startDate;
    //                                     final String startTime = _startTime.toString();
    //                                     final String endDate = _endDate;
    //                                     final String endTime = _endTime.toString();
    //                                     final String description =
    //                                         _description.text;
    //                                     final String id = docId.toString();
    //                                     if (destination.isEmpty ||
    //                                         route.isEmpty ||
    //                                         startDate.isEmpty ||
    //                                         description.isEmpty) {
    //                                       ScaffoldMessenger.of(context)
    //                                           .showSnackBar(SnackBar(
    //                                               content: Text('Empty')));
    //                                     } else {                                     
    //                                       DocumentReference docRef = await FirebaseFirestore.instance.collection("planTrip").doc();
    //                                       docRef.set({
    //                                         "destination": destination,
    //                                         "route": route,
    //                                         "startdate": startDate,
    //                                         "starttime": startTime,
    //                                         "enddate": endDate,
    //                                         "endtime": endTime,
    //                                         "description": description,
    //                                         "email": firebaseUser!.email,
    //                                         "id": docRef.id
    //                                       });
                                          
                                          
    //                                     Navigator.push(
    //                                           context,
    //                                           MaterialPageRoute(
    //                                               builder: (context) =>
    //                                                   HomeScreen()));

    //                                     }
    //                                   },
    //                                   child: Text(
    //                                     "CREATE",
    //                                     style: TextStyle(
    //                                       fontWeight: FontWeight.bold,
    //                                       fontSize: MediaQuery.of(context)
    //                                               .size
    //                                               .width *
    //                                           0.03,
    //                                       color: Colors.white,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             Padding(padding: EdgeInsets.only(bottom: 20)),
    //                           ],
    //                         ),
    //                       ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
