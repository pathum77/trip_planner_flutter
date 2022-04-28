import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/home/joinned/joinListView.dart';
import 'package:trip_planner/home/newHome.dart';

class JoinTripId extends StatefulWidget {
  
  const JoinTripId({Key? key}) : super(key: key);

  @override
  _JoinTripIdState createState() => _JoinTripIdState();
}

class _JoinTripIdState extends State<JoinTripId> {
 
TextEditingController adultValue = TextEditingController();
TextEditingController teenValue = TextEditingController();
TextEditingController kidValue = TextEditingController();
TextEditingController tripId = TextEditingController();
TextEditingController searchResult = TextEditingController();
int currentStep = 0;
int adults= 0;
int teens= 0;
int kids= 0;
bool isVisible = false;
bool tripCheck = false;

late String startDate = '';
late String tripCreator = 'Trip Not Found!';
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String dob = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String district = '';
  String imageURL = '';
  String startTime = '';


List<String> destinations = [];

var firebaseUser = FirebaseAuth.instance.currentUser;
late String id;

    List<Step> getSteps()=>[
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: Text("step 1",), 
      content: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter the Trip ID : ",
                )
                ),
                SizedBox(height: 20,),
            TextFormField(
              controller: tripId,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: (){
                      tripId.text = '';
                  }, 
                  icon: Icon(Icons.close)
                  ),
                border: OutlineInputBorder(),
                labelText: "Trip ID"
              ),
            onChanged: (value){
              id = value;
              
            },
          ),
          SizedBox(height: 20,),
          
          Visibility(
            visible: isVisible,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              color: Colors.grey[300],
              child:Column(
                children: [
                 
                  SizedBox(height: 20,),
                  Text(
                    searchResult.text,
                    ),
                  SizedBox(height: 20,)
                ],
              ),
                ),
          ),
          ]
        )
        )
        ),
        Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      title: Text("step 2"), 
      content: Container(
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
        )
    ];

   Future<void> getTripInfo() async{
     
        if(tripId.text.length != 0){
          var colExist = await FirebaseFirestore.instance
              .collection('planTrip')
              .doc(tripId.text)
              .get();
          if(!colExist.exists){
            setState(() {
              isVisible = true;
              searchResult.text = "Trip Not Found!";
            });
          } else {
            FirebaseFirestore.instance.collection('planTrip').doc(tripId.text).snapshots().listen((userData) {
 
    setState(() {
      isVisible = true;
      // for(int i = 0; i<userData.data()!['destination'].length;i++){
      //   destinations.add(userData.data()!['destination'][i]);
      // }
      //destinations = userData.data()!['destination'];
      startDate = userData.data()!['startdate'];
      tripCreator = userData.data()!['email'];
      startTime = userData.data()!['starttime'];

      searchResult.text = 'Trip Created by : ' + tripCreator;
      if(searchResult.text =='Trip Not Found!'){
        tripCheck = false;
    }
    else {
        tripCheck = true;
    }
    });
    });
    
      }

    } else {
          setState(() {
            isVisible = false;
          });
        }
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    //tripId.text = "a";
    // FirebaseFirestore.instance
    // .collection('planTrip')
    // .doc("ESpLfs1WeTyahqYLNEMi")
    // .snapshots()
    // .listen((userData) {
 
    //   for(int i = 0; i<userData.data()!['participant'].length;i++){
    //     item.add(userData.data()!['participant'][i]);
    //   }
    //   print(item);
    // });
    
  }

  @override
  Widget build(BuildContext context) {
    adultValue.text = adults.toString();
    teenValue.text = teens.toString();
    kidValue.text = kids.toString();
    getTripInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Trip"),
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
                    
                    

                  FirebaseFirestore.instance.collection('planTrip').doc(tripId.text).snapshots().listen((userData) {
                    setState(() {
                      for(int i = 0; i<userData.data()!['destination'].length;i++){
                  destinations.add(userData.data()!['destination'][i]);
                       }
                    });
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
                                content: Text("Joined successfully!"),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        String? mail = firebaseUser!.email;
                await FirebaseFirestore.instance.collection('participant').doc().set(
                                                          {
                                                            "tripId": id,
                                                            "participantMail": mail,
                                                            "adults": adultValue.text,
                                                            "teens": teenValue.text,
                                                            "kids": kidValue.text,
                                                            "firstName": firstName,
                                                            "lastName": lastName,
                                                            "imageURL": imageURL,
                                                            "startdate": startDate,
                                                            "starttime": startTime,
                                                            "destination": destinations
                                                          }
                                                        );
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
                                        String? mail = firebaseUser!.email;
                await FirebaseFirestore.instance.collection('participant').doc().set(
                                                          {
                                                            "tripId": id,
                                                            "participantMail": mail,
                                                            "adults": adultValue.text,
                                                            "teens": teenValue.text,
                                                            "kids": kidValue.text,
                                                            "firstName": firstName,
                                                            "lastName": lastName,
                                                            "imageURL": imageURL,
                                                            "startdate": startDate,
                                                            "starttime": startTime,
                                                            "destination": destinations
                                                          }
                                                        );
                                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      joinListView(tripId: tripId.text)));
                                      },
                                      child: Text("TRIP INFO")
                                      ),
                                ],
                              );
                            });                                    

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
                            onPressed: tripCheck ? controls.onStepContinue : controls.onStepCancel
                            
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
    );
  }
}
