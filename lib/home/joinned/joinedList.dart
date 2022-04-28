import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/home/joinned/JoinedReturnScreens/api/pdf_api.dart';
import 'package:trip_planner/home/joinned/joinListView.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class joinedList extends StatefulWidget {
  const joinedList({Key? key}) : super(key: key);

  @override
  _joinedListState createState() => _joinedListState();
}

class _joinedListState extends State<joinedList> {
  TextEditingController startDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  late String destination = '';
  late String tripId = '';
  String firstName = '';
  String lastName = '';


 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  FirebaseFirestore.instance
    .collection('userInformation')
    .doc(FirebaseAuth.instance.currentUser!.email)
    .snapshots()
    .listen((userData) {
 
    setState(() {
      firstName = userData.data()!['firstName'];
      lastName  = userData.data()!['lastName'];
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Joined Trip"),
      ),
      body: Center(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            // ignore: unnecessary_null_comparison
            stream: FirebaseFirestore.instance
                .collection('participant')
                .where('participantMail',
                    isEqualTo: FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        'No Data',
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    ],
                  ),
                );
              }
              final trips = snapshot.data!.docs.reversed;
              List<Widget> repList = [];
               destination;
              for (var trip in trips) {
                if(trip['destination'].length == 1){
                  destination = trip['destination'][0];
                } else if(trip['destination'].length == 2){
                  destination = trip['destination'][0] + " and " + trip['destination'][1];
                } else {
                  destination = trip['destination'][0] + " , " + trip['destination'][1] + " and " + (trip['destination'].length - 2).toString() + " other place(s)";
                }
                //final destination = trip['destination'];
                final startdate = trip['startdate'];
                final starttime = trip['starttime'];
                final tripId = trip['tripId'];
                final refID = trip.reference.id;

                repList.add(
                  repListBuilder(
                    destination,
                    startdate,
                    starttime,
                    tripId,
                    refID,
                    mediaData,
                    context,
                  ),
                );
              }
              return ListView.builder(
                itemCount: repList.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: repList[index],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget repListBuilder(
    destination,
    startdate,
    starttime,
    tripId,
    refID,
    MediaQueryData mediaData,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => joinListView(tripId: tripId)));
      },
      child: Container(
        // margin: EdgeInsets.only(top: 10.0),
        // width: mediaData.size.width * 0.95,
        // height: mediaData.size.height * 0.15,
        // decoration: BoxDecoration(
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey,
        //       offset: Offset.zero,
        //       blurRadius: 10,
        //       spreadRadius: 1,
        //     ),
        //   ],
        //   borderRadius: BorderRadius.circular(20.0),
        //   color: Colors.white,
        // ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(top: 8.0, left: 14.0),
        //       child: Text(
        //         destination,
        //         style: TextStyle(
        //           fontSize: mediaData.size.height * 0.021,
        //           fontFamily: 'Exo2',
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 2.0, left: 14.0),
        //       child: Text(
        //         'On ' + startdate.toString() + ' AT ' + starttime.toString(),
        //         style: TextStyle(
        //           fontSize: mediaData.size.height * 0.02,
        //           fontFamily: 'Exo2',
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        child: Card(
                       shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15.0),
                        ),
                      color: Colors.blue,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(destination,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text( 'ON ' + startdate.toString() + ' AT ' + starttime.toString(),
                          style: TextStyle(
                            color: Colors.white
                          ),
                          ),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 0),
                              // child: Icon(Icons.keyboard_arrow_right_rounded,
                              // color: Colors.white
                              // )
                              // child: IconButton(
                              //   onPressed: () async {
                              //     final pdfFile = await classPdfApi.generateCenteredText('Simple text')
                              //   }, 
                              //   icon: Icon(Icons.picture_as_pdf_rounded,
                              //   color: Colors.white,
                              //   )
                              //   ),
                        ),
                      ),
                     ),
 
      ),
    );
  }
}


