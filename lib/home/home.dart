// import 'package:flutter/material.dart';
// import 'package:trip_planner/home/UserInfo.dart';
// import 'package:trip_planner/home/create/planTrip.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:trip_planner/home/created/PlannedTrip.dart';
// import 'package:trip_planner/home/join/joinTripId.dart';
// import 'package:trip_planner/home/joinned/joinedList.dart';
// import 'package:trip_planner/home/menu_item.dart';
// import 'package:trip_planner/home/menu_items.dart';
// import 'package:trip_planner/home/settings.dart';
// import 'package:trip_planner/home/share.dart';
// import 'package:trip_planner/login/login.dart';

// User? loggedInUser;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({ Key? key }) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {

//   final _auth = FirebaseAuth.instance;

//   @override
//   void initState() {
//     super.initState();
//     loggedInUser = FirebaseAuth.instance.currentUser;
//     print(loggedInUser!.email);
//   }

//   void choiceAction(String choice){
//     print('working');
//   }

// PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
//     value: item,
//     child: Row(
//       children: [
//         Icon(item.icon, color: Colors.black, size: 20,),
//         const SizedBox(width: 12,),
//         Text(item.text),
//       ],
//     ),
//   );

//   void onSelected(BuildContext context, MenuItem item){
//     switch (item){
//       case MenuItems.itemSettings:
//       Navigator.of(context).push(
//         MaterialPageRoute(builder: (context)=>Settings()),
//       );
//       break;

//       case MenuItems.itemShare:
//       Navigator.of(context).push(
//         MaterialPageRoute(builder: (context)=>Share()),
//       );
//       break;

//       case MenuItems.itemProfile:
      
//       Navigator.of(context).push(
//         MaterialPageRoute(builder: (context)=>UserInformationFloating()),
//       );
//       break;

//       case MenuItems.itemSignOut:
//       _auth.signOut();
//       //Navigator.pop(context);
//       Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       LogIn()));
//     }
//   }  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         toolbarHeight: MediaQuery.of(context).size.height * 0.1,

//         title: Text("Trip Planner",
//         style: TextStyle(
//           fontSize: MediaQuery.of(context).size.width * 0.06,
//         ),
//         ),
//         actions: [
//           PopupMenuButton<MenuItem>(
//             onSelected: (item) => onSelected(context, item),
//             itemBuilder: (context) => [
//               ...MenuItems.itemsFirst.map(buildItem).toList(),
//               PopupMenuDivider(),
//               ...MenuItems.itemsSecond.map(buildItem).toList(),
//             ],
//           ),
//         ],
//       ),
      
//       body: Container(
//         decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.blue.shade100,
//                       Colors.blue.shade200,
//                       Colors.purple.shade100,

//                     ]),
//               ),

//               height: MediaQuery.of(context).size.height,
//               width: double.infinity,
//         child: Center(
//           child: ListView(
//             scrollDirection: Axis.vertical,
//             padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
//             children: [

//               SizedBox(height: MediaQuery.of(context).size.height * 0.06,),

//               Container(  //button 1 start
//                 height: MediaQuery.of(context).size.height * 0.15,
//                 width: MediaQuery.of(context).size.width * 0.9,  
//                   // ignore: deprecated_member_use
//                   child: FlatButton(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.08,),
//                     ),
//                     padding: EdgeInsets.all(0.0),
//                     color: Colors.blue,
                    
//                     child: Ink(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.purple,
//                             Colors.blue,
//                           ],
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight
//                         ),
//                         borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.08,),
//                       ),
//                       child: Container(
//                         constraints: BoxConstraints(
//                           maxWidth: MediaQuery.of(context).size.width * 0.9,
//                           maxHeight: MediaQuery.of(context).size.height * 0.15,
//                         ),
//                         alignment: Alignment.center,
//                         child: Text("Plan a Trip",
//                         style: TextStyle(
//                         color: Colors.white,
//                         fontSize: MediaQuery.of(context).size.width * 0.06,
//                       ),
//                         ),
//                         ),
//                     ),
//                       onPressed: (){
//                         Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => PlanTrip()));
//                       },
//                       ),
//               ),  //button 1 end

//               SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              
//               Container(  //button 2 start
//                 height: MediaQuery.of(context).size.height * 0.15,
//                 width: MediaQuery.of(context).size.width * 0.9,  
//                   // ignore: deprecated_member_use
//                   child: FlatButton(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.08,),
//                     ),
//                     padding: EdgeInsets.all(0.0),
//                     color: Colors.blue,
                    
//                     child: Ink(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.purple,
//                             Colors.blue,
//                           ],
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight
//                         ),
//                         borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.08,),
//                       ),
//                       child: Container(
//                         constraints: BoxConstraints(
//                           maxWidth: MediaQuery.of(context).size.width * 0.9,
//                           maxHeight: MediaQuery.of(context).size.height * 0.15,
//                         ),
//                         alignment: Alignment.center,
//                         child: Text("Planned Trips",
//                         style: TextStyle(
//                         color: Colors.white,
//                         fontSize: MediaQuery.of(context).size.width * 0.06,
//                       ),
//                         ),
//                         ),
//                     ),
//                       onPressed: (){
//                         Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => PlannedTrip()));
//                       },
//                       ),
//               ),  //button 2 end

//               SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              
//               Container(  //button 3 start
//                 height: MediaQuery.of(context).size.height * 0.15,
//                 width: MediaQuery.of(context).size.width * 0.9,  
//                   // ignore: deprecated_member_use
//                   child: FlatButton(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.08,),
//                     ),
//                     padding: EdgeInsets.all(0.0),
//                     color: Colors.blue,
                    
//                     child: Ink(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.purple,
//                             Colors.blue,
//                           ],
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight
//                         ),
//                         borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.08,),
//                       ),
//                       child: Container(
//                         constraints: BoxConstraints(
//                           maxWidth: MediaQuery.of(context).size.width * 0.9,
//                           maxHeight: MediaQuery.of(context).size.height * 0.15,
//                         ),
//                         alignment: Alignment.center,
//                         child: Text("Join a Trip",
//                         style: TextStyle(
//                         color: Colors.white,
//                         fontSize: MediaQuery.of(context).size.width * 0.06,
//                       ),
//                         ),
//                         ),
//                     ),
//                       onPressed: (){
//                         Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => JoinTripId()));
//                       },
//                       ),
//               ),  //button 3 end

//               SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              
//               Container(  //button 4 start
//                 height: MediaQuery.of(context).size.height * 0.15,
//                 width: MediaQuery.of(context).size.width * 0.9,  
//                   // ignore: deprecated_member_use
//                   child: FlatButton(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.08,),
//                     ),
//                     padding: EdgeInsets.all(0.0),
//                     color: Colors.blue,
                    
//                     child: Ink(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.purple,
//                             Colors.blue,
//                           ],
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight
//                         ),
//                         borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.08,),
//                       ),
//                       child: Container(
//                         constraints: BoxConstraints(
//                           maxWidth: MediaQuery.of(context).size.width * 0.9,
//                           maxHeight: MediaQuery.of(context).size.height * 0.15,
//                         ),
//                         alignment: Alignment.center,
//                         child: Text("Joinned Trip",
//                         style: TextStyle(
//                         color: Colors.white,
//                         fontSize: MediaQuery.of(context).size.width * 0.06,
//                       ),
//                         ),
//                         ),
//                     ),
//                       onPressed: (){
//                         Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => joinedList()));
//                       },
//                       ),
//               ),  //button 4 end

//               SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FirebaseUser {
//   Object? get email => null;
// }