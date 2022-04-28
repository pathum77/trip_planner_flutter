import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:trip_planner/home/joinned/JoinedReturnScreens/budget.dart';
import 'package:trip_planner/home/joinned/JoinedReturnScreens/chat.dart';
import 'package:trip_planner/home/joinned/JoinedReturnScreens/info.dart';
import 'package:trip_planner/home/joinned/JoinedReturnScreens/participant.dart';

class joinListView extends StatefulWidget {
  final String tripId;
  
  const joinListView({ Key? key, required this.tripId}) : super(key: key);

  @override
  _joinListViewState createState() => _joinListViewState();
}

class _joinListViewState extends State<joinListView> {

  TextEditingController test = TextEditingController();
  late String description;
  late String startDate;
  late String startTime;
  late String endDate;
  late String endTime;
  late String mail;
  List<String> item = [];
  List<String> destination = [];
  int currentIndex = 0;

   naviPages(){
    switch(currentIndex){
      case 1:
        return JoinedParticipantScreen(tid: widget.tripId);
      case 2:
        return JoinnedBudgetScreen(tid: widget.tripId);
      case 3:
        return JoinedChatScreen(tid: widget.tripId);
      case 0:
      default:
        return JoinedInfoScreen(tid: widget.tripId);
      
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: naviPages(),
    bottomNavigationBar: BottomNavyBar(
      animationDuration: Duration(milliseconds: 200),
      curve: Curves.ease,
      selectedIndex: currentIndex,
      onItemSelected: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.info_outline),
          title: Text("Info"),
          activeColor: Colors.amber,
          inactiveColor: Colors.amber
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.supervised_user_circle),
          title: Text("Participant"),
          activeColor: Colors.green,
          inactiveColor: Colors.green
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.attach_money_rounded),
          title: Text("Budget"),
          activeColor: Colors.red,
          inactiveColor: Colors.red
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.chat),
          title: Text("Chat"),
          activeColor: Colors.blue,
          inactiveColor: Colors.blue
        ),
      ],
    ),
    );
  }
}