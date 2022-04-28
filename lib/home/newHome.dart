import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/home/UserInfo.dart';
import 'package:trip_planner/home/create/planTrip.dart';
import 'package:trip_planner/home/created/PlannedTrip.dart';
import 'package:trip_planner/home/join/joinTripId.dart';
import 'package:trip_planner/home/joinned/joinedList.dart';
import 'package:trip_planner/home/menu_item.dart';
import 'package:trip_planner/home/menu_items.dart';
import 'package:trip_planner/home/settings.dart';
import 'package:trip_planner/login/login.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({ Key? key }) : super(key: key);

  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {

  final _auth = FirebaseAuth.instance;

PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
    value: item,
    child: Row(
      children: [
        Icon(item.icon, color: Colors.blue, size: 20,),
        const SizedBox(width: 12,),
        Text(item.text),
      ],
    ),
  );

  void onSelected(BuildContext context, MenuItem item){
    switch (item){
      // case MenuItems.itemSettings:
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context)=>Settings()),
      // );
      // break;

      // case MenuItems.itemShare:
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context)=>Settings()),
      // );
      // break;

      case MenuItems.itemProfile:
      
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>UserInformationFloating()),
      );
      break;

      case MenuItems.itemSignOut:
      _auth.signOut();
      //Navigator.pop(context);
      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LogIn()));
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            color: Colors.indigo[900],
          ),
          InkWell(
            onTap: (){
                        Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => joinedList()));
            },
            child: Container(/////////////////////////////joined trip
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.82,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.17,
                      //color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.width * 0.25,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                              height: MediaQuery.of(context).size.width * 0.20,
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                color: Colors.white,
                                width: 3
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.10,
                                  height: MediaQuery.of(context).size.width * 0.10,
                                  child: Image.asset('assets/dashJoined.png',
                              ),
                                ),
                              ),
                              
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.62,
                            height: MediaQuery.of(context).size.width * 0.25,
                            //color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.50,
                                  height: MediaQuery.of(context).size.width * 0.08,
                                  //color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("JOINED TRIP",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.width * 0.06,
                                      color: Colors.white
                                    ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0,),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.58,
                                  height: MediaQuery.of(context).size.width * 0.07,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("all the trip(s) that you already in",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.width * 0.25,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                  color: Colors.white,
                                  width: 2
                                    ),
                                  ),
                                  child: Icon(Icons.keyboard_arrow_right_outlined,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width * 0.09
                                  ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
                        Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JoinTripId()));
            },
            child: Container(/////////////////////////////join trip
              height: MediaQuery.of(context).size.height * 0.81,
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.63,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.17,
                      //color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.width * 0.25,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                              height: MediaQuery.of(context).size.width * 0.20,
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                color: Colors.white,
                                width: 3
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.width * 0.11,
                                  child: Image.asset('assets/dashJoin.png')
                                  )
                                  )
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.62,
                            height: MediaQuery.of(context).size.width * 0.25,
                            //color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.50,
                                  height: MediaQuery.of(context).size.width * 0.08,
                                  //color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("JOIN TRIP",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.width * 0.06,
                                      color: Colors.white
                                    ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0,),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.50,
                                  height: MediaQuery.of(context).size.width * 0.07,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("join a trip created by others",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.width * 0.25,
                            //color: Colors.red,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                  color: Colors.white,
                                  width: 2
                                    ),
                                  ),
                                  child: Icon(Icons.keyboard_arrow_right_outlined,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width * 0.09
                                  ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
                        Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlannedTrip()));
            },
            child: Container(///////////////////////////////planed trip
              height: MediaQuery.of(context).size.height * 0.62,
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.44,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.17,
                      //color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.width * 0.25,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                              height: MediaQuery.of(context).size.width * 0.20,
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                color: Colors.white,
                                width: 3
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.10,
                            height: MediaQuery.of(context).size.width * 0.10,
                                  child: Image.asset('assets/dashPlanned.png')
                                  )
                                  )
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.62,
                            height: MediaQuery.of(context).size.width * 0.25,
                            //color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.50,
                                  height: MediaQuery.of(context).size.width * 0.08,
                                  //color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("PLANED TRIP",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.width * 0.06,
                                      color: Colors.white
                                    ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0,),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.50,
                                  height: MediaQuery.of(context).size.width * 0.09,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("edit the details that you already planned",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.width * 0.25,
                            //color: Colors.red,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                  color: Colors.white,
                                  width: 2
                                    ),
                                  ),
                                  child: Icon(Icons.keyboard_arrow_right_outlined,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width * 0.09
                                  ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              
                        Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlanTrip()));
            },
            child: Container(////////////////////////////plan trip
              height: MediaQuery.of(context).size.height * 0.43,
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.25,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.17,
                      //color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.width * 0.25,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                              height: MediaQuery.of(context).size.width * 0.20,
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                color: Colors.white,
                                width: 3
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.13,
                            height: MediaQuery.of(context).size.width * 0.13,
                                  child: Image.asset('assets/dashPlan.png')
                                  )
                                  )
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.62,
                            height: MediaQuery.of(context).size.width * 0.25,
                            //color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.50,
                                  height: MediaQuery.of(context).size.width * 0.08,
                                  //color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("PLAN TRIP",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.width * 0.06,
                                      color: Colors.white
                                    ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0,),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.50,
                                  height: MediaQuery.of(context).size.width * 0.07,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("plan your trip",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.width * 0.25,
                            //color: Colors.red,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                  color: Colors.white,
                                  width: 2
                                    ),
                                  ),
                                  child: Icon(Icons.keyboard_arrow_right_outlined,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width * 0.09
                                  ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ),
          ),
          Container( /////////////////////////////////dashboard
            height: MediaQuery.of(context).size.height * 0.24,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                Text("DASHBOARD",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
                ),
                PopupMenuButton<MenuItem>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              ...MenuItems.itemsFirst.map(buildItem).toList(),
              PopupMenuDivider(),
              ...MenuItems.itemsSecond.map(buildItem).toList(),
            ],
          ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}