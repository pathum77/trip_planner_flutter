

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trip_planner/home/created/participantEditView.dart';
import 'package:intl/intl.dart';

class ParticipantEdit extends StatefulWidget {
  final String tripId;
  const ParticipantEdit({Key? key, required this.tripId}) : super(key: key);

  @override
  _ParticipantEditState createState() => _ParticipantEditState();
}

class _ParticipantEditState extends State<ParticipantEdit> {
  late String imageURL;
  late String firstName;
  late String lastName;
  late String district;
  late String mail;
  late String adultsCount;
  late String teensCount;
  late String kidsCount;
  late String participantMail;
  late int totalParticipant;
  late String tripId;
  
  String trpId = '';
  String inviteDate = '';
  late DateTime startSelectedDate;
  List<String> item = [];
  String creatorFirstName = '';
  String creatorLastName = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void _idShare(BuildContext context) {
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share("Hi There!\n $creatorFirstName $creatorLastName is inviting you to join with him/her to new journy to $item on $inviteDate. To know more information please copy and paste below code(id) in TRIP PLANNER...\n id: $trpId",
  sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trpId = widget.tripId;
    FirebaseFirestore.instance
    .collection('planTrip')
    .doc(widget.tripId)
    .snapshots()
    .listen((userData) {
 
    setState(() {
      for(int i = 0; i<userData.data()!['destination'].length;i++){
        item.add(userData.data()!['destination'][i]);
      }
      startSelectedDate = DateTime.parse(userData.data()!['startdate']);
      inviteDate = DateFormat('yyyy-MM-dd').format(startSelectedDate);
      
    });
    });

    User? user = _firebaseAuth.currentUser;
  FirebaseFirestore.instance
    .collection('userInformation')
    .doc(user!.uid)
    .snapshots()
    .listen((userData) {
 
    setState(() {
      creatorFirstName = userData.data()!['firstName'];
      creatorLastName  = userData.data()!['lastName'];
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Participant"),
      ),
      body: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('participant')
                  .where('tripId', isEqualTo: widget.tripId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    tripId = document['tripId'];
                    participantMail = document['participantMail'];
                    adultsCount = document['adults'];
                    teensCount = document['teens'];
                    kidsCount = document['kids'];
                     firstName = document['firstName'];
                     lastName = document['lastName'];
                     imageURL = document['imageURL'];
                    totalParticipant = int.parse(adultsCount) +
                        int.parse(teensCount) +
                        int.parse(kidsCount);

                    return Card(
                      elevation: 10,
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Container(
                            child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue[50],
                        radius: 45,
                        backgroundImage: imageURL.isNotEmpty
                                         ? NetworkImage(imageURL,
                                         )
                                         : Image.asset(
                                "assets/icon_user.png",
                                fit: BoxFit.cover,
                              ).image,
                      ),
                    ),
                          ),
                        ),
                        title: Text(firstName + " " + lastName),
                        subtitle: Text("Total Travellers : " +
                            totalParticipant.toString()),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              width: 40,
                              height: 50,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              participantEditView(
                                                  document.reference.id)));
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                ),
                              )),
                        ),
                      ),
                    );
                  }).toList(),
                );
              })
              ),
              floatingActionButton: new FloatingActionButton.extended(
      elevation: 0.0,
      icon: new Icon(Icons.add_circle_outline_outlined,
      color:Colors.white
      ),
      backgroundColor: Colors.blue,
      onPressed: () async {
        _idShare(context);
      }, label: Text("INVITE"),
    )
    );
  }
}
