import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/home/created/participantEdit.dart';
import 'package:trip_planner/home/created/selectedPlannedTrip.dart';
import 'package:trip_planner/home/joinned/joinedList.dart';

class participantEditView extends StatefulWidget {
  var id;
  participantEditView(this.id);

  @override
  _participantEditViewState createState() => _participantEditViewState();
}

class _participantEditViewState extends State<participantEditView> {

  TextEditingController adults = TextEditingController();
  TextEditingController teens = TextEditingController();
  TextEditingController kids = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController participantMail = TextEditingController();



  alertDialogDelete(BuildContext context){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.warning_rounded,
              color:Colors.red
              ),
            ),
            Text("warning!"),
          ],
        ),
        content: Text("Are you sure want to remove user ${firstName.text} ${lastName.text}?"),
                                  actions: [
                                    MaterialButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("CANCEL"),
                                      ),
                                      MaterialButton(
                                      onPressed: () async {
                                       await FirebaseFirestore.instance.collection('participant').doc(widget.id).delete();
                //                        Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                // builder: (context) => joinedList()));
                Navigator.pop(context);
                Navigator.pop(context);
                                      },
                                      child: Text("REMOVE"),
                                      )
                                  ],
      );
    });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseFirestore.instance.collection('').where('tripId', isEqualTo: widget.id).snapshots().listen((userData) {
    //   setState(() {

    //   });
    // });
    FirebaseFirestore.instance.collection('participant').doc(widget.id).snapshots().listen((userData){
      setState(() {

        adults.text = userData.data()!['adults'];
        teens.text = userData.data()!['teens'];
        kids.text = userData.data()!['kids'];
        firstName.text = userData.data()!['firstName'];
        lastName.text = userData.data()!['lastName'];
        participantMail.text = userData.data()!['participantMail'];
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Participant"),
      ),
       body: Center(
         child: Container(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SizedBox(height: 20,),
               Container(
                 width: MediaQuery.of(context).size.width * 0.9,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, right: 8.0, bottom: 8.0, left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Name : "),
                      Text(firstName.text + " " + lastName.text),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Email : "),
                      Text(participantMail.text),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("\nParticipant"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 60.0, bottom: 8.0, right: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Adults : "),
                      Text(adults.text),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 60.0, bottom: 8.0, right: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kids : "),
                      Text(kids.text),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 60.0, bottom: 8.0, right: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Teens : "),
                      Text(teens.text),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 70.0, bottom: 30.0, right: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Travellers : "),
                      Text((int.parse(adults.text) + int.parse(kids.text) + int.parse(teens.text)).toString()),
                    ],
                  ),
                ),
              ],
            ),
               ),
             ],
           ),
         ),
       ),
      floatingActionButton: new FloatingActionButton(
      elevation: 0.0,
      child: new Icon(Icons.delete),
      backgroundColor: new Color(0xFFE57373),
      onPressed: () async {
        alertDialogDelete(context);
      }
    )
    );
  }
}