
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/home/created/selectedPlannedTrip.dart';

User? loggedInUser;

class PlannedTrip extends StatefulWidget {
  const PlannedTrip({ Key? key }) : super(key: key);

  @override
  _PlannedTripState createState() => _PlannedTripState();
}

class _PlannedTripState extends State<PlannedTrip> {

late String destination;

   @override
  void initState() {
    super.initState();
    loggedInUser = FirebaseAuth.instance.currentUser;
    print(loggedInUser!.email);
  }
  @override
  Widget build(BuildContext context) {
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
          "Planned Trip",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.06,
          ),
        ),
      ),
      body: Center(
        child: Container(
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [
          //         Colors.blue.shade100,
          //         Colors.blue.shade200,
          //         Colors.purple.shade100,
          //       ]),
          // ),

      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('planTrip').where('email', isEqualTo: loggedInUser!.email).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
           
          return ListView(
            children: snapshot.data!.docs.map((document){
              if (document['destination'].length == 1) {
                destination = document['destination'][0];
              } else if(document['destination'].length == 2){
                destination = document['destination'][0] + " and " + document['destination'][1];
              } else{
                destination = document['destination'][0] + " , " + document['destination'][1] + " and " + (document['destination'].length - 2).toString() + " other place(s)"; 
              }
                return GestureDetector(
                   onTap: (){
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) =>
                        SelectedPlannedTrip(document.reference.id)));                 
                   },
                   child: Container(
                    // height: MediaQuery.of(context).size.height * 0.15,
                     child: Card(
                       shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15.0),
                        ),
                      color: Colors.blue,
                      // child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SizedBox(height: 10,),
                         
                      //       Text(destination,
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         color: Colors.white
                      //       ),
                      //       ),
                    
                      //          Text("DEPART ON "+ document['startdate'] + " AT " + document['starttime'],
                      //          style: TextStyle(
                      //            color: Colors.white,
                      //          ),
                      //          ),
                      //          SizedBox(height: 10,),
                      //   ],
                      // ),
                      child: ListTile(
                        //leading: 
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
                          child: Text("DEPART ON "+ document['startdate'] + " AT " + document['starttime'],
                          style: TextStyle(
                            color: Colors.white
                          ),
                          ),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 0),
                          // child: Container(
                          //     decoration: BoxDecoration(
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: Colors.grey.withOpacity(0.5),
                          //           spreadRadius: 5,
                          //           blurRadius: 7,
                          //           offset: Offset(
                          //               0, 3), // changes position of shadow
                          //         ),
                          //       ],
                          //       shape: BoxShape.circle,
                          //       color: Colors.white,
                          //     ),
                          //     width: 40,
                          //     height: 50,
                              child: Icon(Icons.keyboard_arrow_right_rounded,
                              color: Colors.white
                              )
                             // ),
                        ),
                      ),
                     ),
                   )
                 );
            }).toList(),
          );
        }
      )
        ),
        ),
    );
  }
}