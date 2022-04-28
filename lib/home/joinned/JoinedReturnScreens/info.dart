import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/home/newHome.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

class JoinedInfoScreen extends StatefulWidget {
  final String tid;
  const JoinedInfoScreen({ Key? key, required this.tid }) : super(key: key);

  @override
  _JoinedInfoScreenState createState() => _JoinedInfoScreenState();
}

class _JoinedInfoScreenState extends State<JoinedInfoScreen> {

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
TextEditingController description = TextEditingController();
TextEditingController startDate = TextEditingController();
TextEditingController startTime = TextEditingController();
TextEditingController endDate = TextEditingController();
TextEditingController endTime = TextEditingController();
TextEditingController tripCreatorFirstName = TextEditingController();
TextEditingController tripCreatorLastName = TextEditingController();
List<String> destinations = [];
TextEditingController adultValue = TextEditingController();
TextEditingController teenValue = TextEditingController();
TextEditingController kidValue = TextEditingController();
int adults= 0;
int teens= 0;
int kids= 0;

Future<void> pdfGenerate() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text('Hello World!'),
      ),
    ),
  );

  final file = File('example.pdf');
  await file.writeAsBytes(await pdf.save());
}

alertDialogDelete(BuildContext context){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("warning!"),
        content: Text("Are you sure?"),
                                  actions: [
                                    MaterialButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("CANCEL"),
                                      ),
                                      MaterialButton(
                                      onPressed: () async {
              var result = await FirebaseFirestore.instance
      .collection("participant")
      .where("participantMail", isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .where("tripId", isEqualTo: widget.tid)
      .get()
      .then((value){ value.docs
      .forEach((element) { FirebaseFirestore.instance
      .collection("participant")
      .doc(element.id)
      .delete()
      .then((value){ print("Success!"); 
            }); 
          }); 
        });

              Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => NewHomeScreen()));
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
    User? user = _firebaseAuth.currentUser;
    FirebaseFirestore.instance
    .collection('planTrip')
    .doc(widget.tid)
    .snapshots()
    .listen((userData) {
    setState(() {
      for(int i = 0; i<userData.data()!['destination'].length; i++){
        destinations.add(userData.data()!['destination'][i]);
      }
      description.text = userData.data()!['description'];
      startDate.text = userData.data()!['startdate'];
      startTime.text = userData.data()!['starttime'];
      endDate.text = userData.data()!['enddate'];
      endTime.text = userData.data()!['endtime'];
      tripCreatorFirstName.text = userData.data()!['firstName'];
      tripCreatorLastName.text = userData.data()!['lastName'];
    });
    });
    print(widget.tid);
  }

  @override
  Widget build(BuildContext context) {
    adultValue.text = adults.toString();
    teenValue.text = teens.toString();
    kidValue.text = kids.toString();
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
  slivers: <Widget>[
    const SliverAppBar(
     
      backgroundColor: Colors.amber,
      pinned: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('About',
        ),
        
      ),
      
    ),
    SliverToBoxAdapter(
      child: Container(
        color: Colors.amber,
        height: 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                  ),
              ),
            ),
          ],
        ),
      ),
    ),
    SliverList(delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0,),
                  Center(child: Text("TRIP CREATED BY " + tripCreatorFirstName.text +" "+ tripCreatorLastName.text)),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 50.0),
                    child: Text("DESTINATION(S) : "),
                  ),
                  SizedBox(height: 20,),
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: 
                                            destinations.map((element) => Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 100.0, top: 8.0),
                                                      child: Container(
                                                        width: 35,
                                                        height: 35,
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
                                                          borderRadius: BorderRadius.circular(100),
                                                        ),
                                                        child: TextButton(
                                                          onPressed: (){}, 
                                                          child: Icon(Icons.location_on,
                                                          color: Colors.red,
                                                          size: 20,
                                                          ),
                                                          ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                                                      child: Text(element,
                                                      style: TextStyle(
                                                        //fontSize: MediaQuery.of(context).size.width * 0.05
                                                      ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            ).toList(),
                                        ),
                              SizedBox(height: 40,),
                              Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text("START ON " + startDate.text + " AT " + startTime.text),
                                  ),
                                  ),
                              Center(
                                child: Image.asset("assets/timeIcon.png"),
                              ),
                              Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Text("END ON " + endDate.text + " AT " + endTime.text),
                                  ),
                                  ),
                              SizedBox(height: 100.0,),
      //                         Padding(
      //                           padding: const EdgeInsets.only(left: 20, bottom: 20),
      //                           child: Text("Edit your participation"),
      //                         ),
      //                         Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.withOpacity(0.5),
      //         spreadRadius: 5,
      //         blurRadius: 7,
      //         offset: Offset(0, 3),
      //       ),
      //     ],
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(20),
      //       topRight: Radius.circular(20),
      //     ),
      //   ),
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Column(
      //       children: [
      //         SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
      //         //ADULTS START
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text("Adults : ",
      //             style: TextStyle(
      //               fontSize: MediaQuery.of(context).size.width * 0.05,
      //             ),
      //             ),
      //                 Container(
      //                   child: Row(
      //                     children: [
      //                       Container(
      //                         decoration: BoxDecoration(
      //                           boxShadow: [
      //                             BoxShadow(
      //                             color: Colors.grey.withOpacity(0.5),
      //                             spreadRadius: 5,
      //                             blurRadius: 7,
      //                             offset: Offset(0, 3), // changes position of shadow
      //                             ),
      //                           ],
      //                           shape: BoxShape.circle,
      //                           color: Colors.white,
      //                         ),
      //                         child: IconButton(
      //                           onPressed: (){
      //                             setState(() {
      //                                     if(adults <= 0){
      //                                       adults= 0;
      //                                     } else{
      //                                       adults--;
      //                                     }
      //                                   });
      //                           }, 
      //                           icon: Icon(Icons.remove,
      //                           ),
      //                           ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 5, right: 5),
      //                         child: Container(
      //                           width: MediaQuery.of(context).size.width * 0.3,
      //                           height: MediaQuery.of(context).size.width * 0.13,
      //                           child: TextFormField(
      //                             enableInteractiveSelection: false,
      //                             textAlign: TextAlign.center,
      //                             controller: adultValue,
      //                             readOnly: true,
      //                             decoration: InputDecoration(
      //                               border: OutlineInputBorder(
      //                                 borderRadius: BorderRadius.circular(10.0),
      //                               )
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         decoration: BoxDecoration(
      //                           boxShadow: [
      //                             BoxShadow(
      //                             color: Colors.grey.withOpacity(0.5),
      //                             spreadRadius: 5,
      //                             blurRadius: 7,
      //                             offset: Offset(0, 3),
      //                             ),
      //                           ],
      //                           shape: BoxShape.circle,
      //                           color: Colors.white,
      //                         ),
      //                         child: IconButton(
      //                           onPressed: (){
      //                             setState(() {
      //                                     adults++;
      //                                   });
      //                           }, 
      //                           icon: Icon(Icons.add)
      //                           ),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //           ],
      //         ),
      //         //ADULTS END
      //         SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
      //         //TEEN START
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text("Teens : ",
      //             style: TextStyle(
      //               fontSize: MediaQuery.of(context).size.width * 0.05,
      //             ),
      //             ),
      //                 Container(
      //                   child: Row(
      //                     children: [
      //                       Container(
      //                         decoration: BoxDecoration(
      //                           boxShadow: [
      //                             BoxShadow(
      //                             color: Colors.grey.withOpacity(0.5),
      //                             spreadRadius: 5,
      //                             blurRadius: 7,
      //                             offset: Offset(0, 3), // changes position of shadow
      //                             ),
      //                           ],
      //                           shape: BoxShape.circle,
      //                           color: Colors.white,
      //                         ),
      //                         child: IconButton(
      //                           onPressed: (){
      //                             setState(() {
      //                                     if(teens <= 0){
      //                                       teens = 0;
      //                                     } else{
      //                                       teens--;
      //                                     }
      //                                   });
      //                           }, 
      //                           icon: Icon(Icons.remove,
      //                           ),
      //                           ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 5, right: 5),
      //                         child: Container(
      //                           width: MediaQuery.of(context).size.width * 0.3,
      //                           height: MediaQuery.of(context).size.width * 0.13,
      //                           child: TextFormField(
      //                             enableInteractiveSelection: false,
      //                             textAlign: TextAlign.center,
      //                             controller: teenValue,
      //                             readOnly: true,
      //                             decoration: InputDecoration(
      //                               border: OutlineInputBorder(
      //                                 borderRadius: BorderRadius.circular(10.0),
      //                               )
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         decoration: BoxDecoration(
      //                           boxShadow: [
      //                             BoxShadow(
      //                             color: Colors.grey.withOpacity(0.5),
      //                             spreadRadius: 5,
      //                             blurRadius: 7,
      //                             offset: Offset(0, 3),
      //                             ),
      //                           ],
      //                           shape: BoxShape.circle,
      //                           color: Colors.white,
      //                         ),
      //                         child: IconButton(
      //                           onPressed: (){
      //                             setState(() {
      //                                     teens++;
      //                                   });
      //                           }, 
      //                           icon: Icon(Icons.add)
      //                           ),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //           ],
      //         ),
      //         //TEEN END
      //         SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
      //         //KID START
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text("Kids : ",
      //             style: TextStyle(
      //               fontSize: MediaQuery.of(context).size.width * 0.05,
      //             ),
      //             ),
      //                 Container(
      //                   child: Row(
      //                     children: [
      //                       Container(
      //                         decoration: BoxDecoration(
      //                           boxShadow: [
      //                             BoxShadow(
      //                             color: Colors.grey.withOpacity(0.5),
      //                             spreadRadius: 5,
      //                             blurRadius: 7,
      //                             offset: Offset(0, 3), // changes position of shadow
      //                             ),
      //                           ],
      //                           shape: BoxShape.circle,
      //                           color: Colors.white,
      //                         ),
      //                         child: IconButton(
      //                           onPressed: (){
      //                             setState(() {
      //                                     if(kids <= 0){
      //                                       kids = 0;
      //                                     } else{
      //                                       kids--;
      //                                     }
      //                                   });
      //                           }, 
      //                           icon: Icon(Icons.remove,
      //                           ),
      //                           ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 5, right: 5),
      //                         child: Container(
      //                           width: MediaQuery.of(context).size.width * 0.3,
      //                           height: MediaQuery.of(context).size.width * 0.13,
      //                           child: TextFormField(
      //                             enableInteractiveSelection: false,
      //                             textAlign: TextAlign.center,
      //                             controller: kidValue,
      //                             readOnly: true,
      //                             decoration: InputDecoration(
      //                               border: OutlineInputBorder(
      //                                 borderRadius: BorderRadius.circular(10.0),
      //                               )
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         decoration: BoxDecoration(
      //                           boxShadow: [
      //                             BoxShadow(
      //                             color: Colors.grey.withOpacity(0.5),
      //                             spreadRadius: 5,
      //                             blurRadius: 7,
      //                             offset: Offset(0, 3),
      //                             ),
      //                           ],
      //                           shape: BoxShape.circle,
      //                           color: Colors.white,
      //                         ),
      //                         child: IconButton(
      //                           onPressed: (){
      //                             setState(() {
      //                                     kids++;
      //                                   });
      //                           }, 
      //                           icon: Icon(Icons.add)
      //                           ),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //           ],
      //         ),
      //         SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Container(
      //               decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(30),
      //             border: Border.all(
      //               color: Colors.amber,
      //               width: 1
      //             ),
      //             ),
      //               width: 100,
      //               height: 40,
      //               child: FlatButton(
      //                 onPressed: (){}, 
      //                 child: Text("CANCEL",
      //                 style: TextStyle(
      //                   color: Colors.amber,
      //                 ),
      //                 ),
                      
      //                 ),
      //             ),
      //             SizedBox(width: 20,),
      //             Container(
      //               width: 100,
      //               height: 40,
      //               decoration: BoxDecoration(
      //                 color: Colors.amber,
      //                 borderRadius: BorderRadius.circular(30)
      //               ),
      //               child: FlatButton(
      //                 onPressed: () async {
      // //                   var result = await FirebaseFirestore.instance
      // // .collection("participant")
      // // .where("participantMail", isEqualTo: FirebaseAuth.instance.currentUser!.email)
      // // .where("tripId", isEqualTo: widget.tid)
      // // .
      
      //                 }, 
      //                 child: Text("SAVE",
      //                 style: TextStyle(
      //                   color: Colors.white,
      //                 ),
      //                 ),
                      
      //                 ),
      //             )
      //           ],
      //         )
      //       ]
      //     ),
      //   )
      // ),
      //SizedBox(height: 100,)
      FlatButton(onPressed: pdfGenerate, child: Text("Generate"))
                ],
              ),
    ]))
  ],
),
floatingActionButton: new FloatingActionButton.extended(
      elevation: 0.0,
      icon: new Icon(Icons.remove_circle_outline_outlined,
      color:Colors.white
      ),
      backgroundColor: Colors.red,
      onPressed: () async {
        alertDialogDelete(context);
       
      }, label: Text("LEAVE"),
    )
    );
  }
}

// import 'dart:io';

// import 'package:pdf/widgets.dart' as pw;

// Future<void> main() async {
//   final pdf = pw.Document();

//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) => pw.Center(
//         child: pw.Text('Hello World!'),
//       ),
//     ),
//   );

//   final file = File('example.pdf');
//   await file.writeAsBytes(await pdf.save());
// }