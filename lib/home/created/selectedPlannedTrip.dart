import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/home/created/budget.dart';
import 'package:trip_planner/home/created/participantEdit.dart';
import 'package:intl/intl.dart';
import 'package:trip_planner/home/newHome.dart';

// ignore: must_be_immutable
class SelectedPlannedTrip extends StatefulWidget {
  var id;
  SelectedPlannedTrip(this.id);

  @override
  _SelectedPlannedTripState createState() => _SelectedPlannedTripState();
}

class _SelectedPlannedTripState extends State<SelectedPlannedTrip> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController des = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController sd = new TextEditingController();
  TextEditingController st = new TextEditingController();
  TextEditingController ed = new TextEditingController();
  TextEditingController et = new TextEditingController();
  late String _destination;
  late String startDate;
  late String startTime;
  late String endDate;
  late String endTime;
  String inviteDate = '';
  List<String> item = [];
  late TimeOfDay time;
  late TimeOfDay startPicked;
  late TimeOfDay endPicked;
  late DateTime startSelectedDate;
  late DateTime endSelectedDate;
  late String firstName = '';
  late String lastName = '';
  String trpId = '';

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Destination"),
            content: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (value) {
                _destination = value;
              },
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
              decoration: InputDecoration(
                labelText: "Destination",
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
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

  selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startSelectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != startSelectedDate)
      setState(() {
        startSelectedDate = picked;
        sd.text = DateFormat('yyyy-MM-dd').format(startSelectedDate);
      });
  }

  selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endSelectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != endSelectedDate)
      setState(() {
        endSelectedDate = picked;
        ed.text = DateFormat('yyyy-MM-dd').format(endSelectedDate);
      });
  }

  alertDialogDelete(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                ),
                Text("warning!"),
              ],
            ),
            content: Text(
                "Are you sure?\nThis will erase your all the information below this trip!"),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("CANCEL"),
              ),
              MaterialButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('planTrip')
                      .doc(widget.id)
                      .delete();
                  await FirebaseFirestore.instance
                      .collection('budget')
                      .doc(widget.id)
                      .delete();
                  FirebaseFirestore.instance
                      .collection("participant")
                      .where("tripId", isEqualTo: widget.id)
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      FirebaseFirestore.instance
                          .collection("participant")
                          .doc(element.id)
                          .delete()
                          .then((value) {
                        print("Success!");
                      });
                    });
                  });
                  FirebaseFirestore.instance
                      .collection("chat")
                      .where("tripId", isEqualTo: widget.id)
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      FirebaseFirestore.instance
                          .collection("chat")
                          .doc(element.id)
                          .delete()
                          .then((value) {
                        print("Success!");
                      });
                    });
                  });

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewHomeScreen()));
                },
                child: Text("DETETE"),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trpId = widget.id;
    time = TimeOfDay.now();
    FirebaseFirestore.instance
        .collection('planTrip')
        .doc(widget.id)
        .snapshots()
        .listen((userData) {
      setState(() {
        for (int i = 0; i < userData.data()!['destination'].length; i++) {
          item.add(userData.data()!['destination'][i]);
        }

        st.text = userData.data()!['starttime'];
        et.text = userData.data()!['endtime'];
        startSelectedDate = DateTime.parse(userData.data()!['startdate']);
        sd.text = DateFormat('yyyy-MM-dd').format(startSelectedDate);
        inviteDate = DateFormat('yyyy-MM-dd').format(startSelectedDate);
        endSelectedDate = DateTime.parse(userData.data()!['enddate']);
        ed.text = DateFormat('yyyy-MM-dd').format(endSelectedDate);
        description.text = userData.data()!['description'];
      });
    });
    User? user = _firebaseAuth.currentUser;
    FirebaseFirestore.instance
        .collection('userInformation')
        .doc(user!.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        firstName = userData.data()!['firstName'];
        lastName = userData.data()!['lastName'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("PLANNED TRIP"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              size: MediaQuery.of(context).size.width * 0.06,
            ),
            onPressed: () async {
              alertDialogDelete(context);
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('planTrip')
              .where('id', isEqualTo: widget.id)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Budget(
                                            tripId: widget.id,
                                          )));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      Icons.attach_money_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "TOTAL BUDGET",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ParticipantEdit(
                                            tripId: widget.id,
                                          )));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      Icons.supervised_user_circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "PARTICIPANT",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  ListView(
                                    shrinkWrap: true,
                                    children: item
                                        .map(
                                          (element) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40, top: 8),
                                                child: Text(
                                                  element,
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.05),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 50),
                                                child: Container(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        int index = item
                                                            .indexOf(element);
                                                        item.removeAt(index);
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      createAlertDialog(context);
                                    },
                                    icon: Icon(Icons.add_location_alt),
                                    label: Text(
                                      "ADD DESTINATION(S)",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              width: MediaQuery.of(context).size.height * 0.8,
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color.fromARGB(255, 51, 204, 255),
                                    width: 1),
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            Positioned(
                                left: 10,
                                top: 12,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: 10, left: 5, right: 5),
                                  color: Colors.white,
                                  child: Text(
                                    'Destination',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: TextFormField(
                          controller: description,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Description",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(children: [
                          Container(
                            alignment: Alignment.topLeft,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.bottomCenter,
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      startDate = value;
                                    });
                                  },
                                  controller: sd,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        selectStartDate(context);
                                      },
                                      icon: Icon(
                                        Icons.calendar_today_sharp,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: "Start Date",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                width: MediaQuery.of(context).size.width * 0.37,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                  controller: st,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.alarm),
                                    border: OutlineInputBorder(),
                                    labelText: "Start Time",
                                  ),
                                  onTap: () async {
                                    startPicked = (await showTimePicker(
                                        context: context, initialTime: time))!;

                                    startTime = startPicked.format(context);
                                    st.text = startTime;
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

                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: Colors.white60,
                            height: MediaQuery.of(context).size.height * 0.14,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      width: MediaQuery.of(context).size.width *
                                          0.43,
                                      child: TextFormField(
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            endDate = value;
                                          });
                                        },
                                        controller: ed,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                selectEndDate(context);
                                              },
                                              icon: Icon(
                                                Icons.calendar_today_sharp,
                                              )),
                                          border: OutlineInputBorder(),
                                          labelText: "End Date",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      width: MediaQuery.of(context).size.width *
                                          0.37,
                                      child: TextFormField(
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                        ),
                                        controller: et,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.alarm,
                                          ),
                                          border: OutlineInputBorder(),
                                          labelText: "End Time",
                                        ),
                                        onTap: () async {
                                          endPicked = (await showTimePicker(
                                              context: context,
                                              initialTime: time))!;

                                          endTime = endPicked.format(context);
                                          et.text = endTime;
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                              ],
                            ),
                          ),
                          // ),
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.24,
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.blue, width: 2),
                            ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.arrow_back_sharp,
                                    color: Colors.blue)),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30)),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () async {
                                DateTime start = DateTime.parse(sd.text);
                                DateTime end = DateTime.parse(ed.text);
                                print(start.isBefore(end));

                                final List<String> destination = item.toList();
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
                                        await FirebaseFirestore.instance
                                      .collection('planTrip')
                                      .doc(widget.id)
                                      .update({
                                    "destination": destination,
                                    "description": description.text,
                                    "starttime": st.text,
                                    "endtime": et.text,
                                    "startdate": sd.text,
                                    "enddate": ed.text,
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewHomeScreen()));

                                  var result = await FirebaseFirestore.instance
                                      .collection("participant")
                                      .where("tripId", isEqualTo: widget.id)
                                      .get()
                                      .then((value) {
                                    value.docs.forEach((element) {
                                      FirebaseFirestore.instance
                                          .collection("participant")
                                          .doc(element.id)
                                          .update({
                                        "destination": destination,
                                      }).then((value) {
                                        print("Success!");
                                      });
                                    });
                                  });
                                      }
                                }
                              },
                              child: Text(
                                "SAVE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
