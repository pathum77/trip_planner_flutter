import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JoinedParticipantScreen extends StatefulWidget {
  final String tid;
  
  const JoinedParticipantScreen({ Key? key, required this.tid, }) : super(key: key);

  @override
  _JoinedParticipantScreenState createState() => _JoinedParticipantScreenState();
}

class _JoinedParticipantScreenState extends State<JoinedParticipantScreen> {
  late String firstName;
  late String lastName;
  late String adults;
  late String teens;
  late String kids;
  late String imageURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Participant"),
        backgroundColor: Colors.green,
      ),
      body: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('participant')
                  .where('tripId', isEqualTo: widget.tid)
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
                    firstName = document['firstName'];
                    lastName= document['lastName'];
                    adults = document['adults'];
                    teens = document['teens'];
                    kids = document['kids'];
                    imageURL = document['imageURL'];
                    
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
                        subtitle: Text("Total Travellers : " + (int.parse(adults) + int.parse(teens) + int.parse(kids)).toString()),
                        // trailing: Padding(
                        //   padding: const EdgeInsets.only(right: 0),
                        //   child: Container(
                        //       decoration: BoxDecoration(
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey.withOpacity(0.5),
                        //             spreadRadius: 5,
                        //             blurRadius: 7,
                        //             offset: Offset(
                        //                 0, 3), // changes position of shadow
                        //           ),
                        //         ],
                        //         shape: BoxShape.circle,
                        //         color: Colors.white,
                        //       ),
                        //       width: 40,
                        //       height: 50,
                        //       child: IconButton(
                        //         onPressed: () {
                        //           // Navigator.push(
                        //           //     context,
                        //           //     MaterialPageRoute(
                        //           //         builder: (context) =>
                        //           //             participantEditView(
                        //           //                 document.reference.id)));
                        //         },
                        //         icon: Icon(
                        //           Icons.keyboard_arrow_down
                        //         ),
                        //       )),
                        // ),
                      ),
                    );
                   // );
                  }).toList(),
                );
              })
              ),
    );
  }
}