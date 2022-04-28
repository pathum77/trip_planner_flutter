import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

class JoinnedBudgetScreen extends StatefulWidget {
  final String tid;
  const JoinnedBudgetScreen({ Key? key, required this.tid }) : super(key: key);

  @override
  _JoinnedBudgetScreenState createState() => _JoinnedBudgetScreenState();
}

class _JoinnedBudgetScreenState extends State<JoinnedBudgetScreen> {

  int iTotal = 0;
  String budgetStatus = '';
  TextEditingController total = TextEditingController();
  TextEditingController food = TextEditingController();
  TextEditingController drinks = TextEditingController();
  TextEditingController accomondation = TextEditingController();
  TextEditingController transport = TextEditingController();
  TextEditingController others = TextEditingController();
  TextEditingController precentFood = TextEditingController();
  TextEditingController precentDrinks = TextEditingController();
  TextEditingController precentAccomondation = TextEditingController();
  TextEditingController precentTransport = TextEditingController();
  TextEditingController precentOthers = TextEditingController();
  double _food = 0.00;
  late double _drinks = 0.00;
  late double _accomondation = 0.00;
  late double _transport = 0.00;
  late double _others = 0.00;
  var formatter = NumberFormat('###,000');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
    .collection('budget')
    .doc(widget.tid)
    .snapshots()
    .listen((userData) {
    setState(() {
       //iTotal = int.parse(userData.data()!['total']);
      // total.text = formatter.format(iTotal).toString();
      if(userData.data()!['total'] == '0'){
        setState(() {
          budgetStatus = 'Budget not set yet!';
          total.text = userData.data()!['total'];
        });
      } else {
        total.text = userData.data()!['total'];
      }
      if(userData.data()!['food'] == ''){
        setState(() {
          food.text = "0";
        });
      } else {
        setState(() {
          food.text = userData.data()!['food'];
        });
      }

      if(userData.data()!['drinks'] == ''){
        setState(() {
          drinks.text = "0";
        });
      } else {
        setState(() {
          drinks.text = userData.data()!['drinks'];
        });
      }

      if(userData.data()!['accomondation'] == ''){
        setState(() {
          accomondation.text = "0";
        });
      } else {
        setState(() {
          accomondation.text = userData.data()!['accomondation'];
        });
      }

      if(userData.data()!['transport'] == ''){
        setState(() {
          transport.text = "0";
        });
      } else {
        setState(() {
          transport.text = userData.data()!['transport'];
        });
      }

      if(userData.data()!['others'] == ''){
        setState(() {
          others.text = "0";
        });
      } else {
        setState(() {
          others.text = userData.data()!['others'];
        });
      }
      
      
      
      _food = double.parse(food.text) / double.parse(total.text);
      precentFood.text = (_food*100).toStringAsFixed(2);

      _drinks = double.parse(drinks.text) / double.parse(total.text);
      precentDrinks.text = (_drinks*100).toStringAsFixed(2);

      _transport = double.parse(transport.text) / double.parse(total.text);
      precentTransport.text = (_transport*100).toStringAsFixed(2);;

      _accomondation = double.parse(accomondation.text) / double.parse(total.text);
      precentAccomondation.text = (_accomondation*100).toStringAsFixed(2);;

      _others = double.parse(others.text) / double.parse(total.text);
      precentOthers.text = (_others*100).toStringAsFixed(2);
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
     body: SingleChildScrollView(
       child: Stack(
         children: [
           Container(
             child: Column(
               children: [
                 Container(
                   width: double.infinity,
                   height: MediaQuery.of(context).size.height * 0.3,
                   color: Colors.red,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       Text(budgetStatus,
                       style: TextStyle(
                         fontSize: 20,
                         color: Colors.white
                       ),
                       ),
                       Text("Total",
                       style: TextStyle(
                         fontSize: 25,
                         color: Colors.white
                       ),
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("RS :",
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 20,
                             color: Colors.white
                           ),
                           ),
                           Text(total.text + "/=",
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 30,
                             color: Colors.white
                           ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
                 Container(
                   width: double.infinity,
                   height: MediaQuery.of(context).size.height * 0.7,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.only(
                       topRight: Radius.circular(20),
                       topLeft: Radius.circular(20),
                     )
                   ),
                   child: SingleChildScrollView(
                     child: Column(
                       children: [
                         Row(
                           children: [
                             SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                               Padding(
                                 padding: const EdgeInsets.only(top: 30),
                                 child: Container(
                                   width: MediaQuery.of(context).size.width * 0.25,
                                   height: 550,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.only(top: 20),
                                         child: Container(
                                           width: 70,
                                           height: 70,
                                           color: Colors.white,
                                           child: Center(
                                             child: CircularPercentIndicator(
                                               radius: 70,
                                               lineWidth: 10,
                                               percent: _food,
                                               progressColor: Colors.red,
                                               backgroundColor: Colors.red.shade50,
                                               circularStrokeCap: CircularStrokeCap.round,
                                               center: Text(precentFood.text + "%"),
                                               ),
                                           ),
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 20),
                                         child: Container(
                                           width: 70,
                                           height: 70,
                                           color: Colors.white,
                                           child: Center(
                                             child: CircularPercentIndicator(
                                               radius: 70,
                                               lineWidth: 10,
                                               percent: _drinks,
                                               progressColor: Colors.red,
                                               backgroundColor: Colors.red.shade50,
                                               circularStrokeCap: CircularStrokeCap.round,
                                               center: Text(precentDrinks.text + "%"),
                                               ),
                                           ),
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 20),
                                         child: Container(
                                           width: 70,
                                           height: 70,
                                           color: Colors.white,
                                           child: Center(
                                             child: CircularPercentIndicator(
                                               radius: 70,
                                               lineWidth: 10,
                                               percent: _transport,
                                               progressColor: Colors.red,
                                               backgroundColor: Colors.red.shade50,
                                               circularStrokeCap: CircularStrokeCap.round,
                                               center: Text(precentTransport.text + "%"),
                                               ),
                                           ),
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 20),
                                         child: Container(
                                           width: 70,
                                           height: 70,
                                           color: Colors.white,
                                           child: Center(
                                             child: CircularPercentIndicator(
                                               radius: 70,
                                               lineWidth: 10,
                                               percent: _accomondation,
                                               progressColor: Colors.red,
                                               backgroundColor: Colors.red.shade50,
                                               circularStrokeCap: CircularStrokeCap.round,
                                               center: Text(precentAccomondation.text + "%"),
                                               ),
                                           ),
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 20),
                                         child: Container(
                                           width: 70,
                                           height: 70,
                                           color: Colors.white,
                                           child: Center(
                                             child: CircularPercentIndicator(
                                               radius: 70,
                                               lineWidth: 10,
                                               percent: _others,
                                               progressColor: Colors.red,
                                               backgroundColor: Colors.red.shade50,
                                               circularStrokeCap: CircularStrokeCap.round,
                                               center: Text(precentOthers.text + "%"),
                                               ),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),


                               Padding(
                                 padding: const EdgeInsets.only(top: 30),
                                 child: Container(
                                   width: MediaQuery.of(context).size.width * 0.65,
                                     height: 550,
                                     child: Column(
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.only(top: 20),
                                           child: Container(
                                             color: Colors.white,
                                             height: 70,
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("FOOD",
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                                 ),
                                                 Text("Rs: " + food.text + "/=",
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.only(top: 20),
                                           child: Container(
                                             color: Colors.white,
                                             height: 70,
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("DRINKS",
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                                 ),
                                                 Text("Rs: " + drinks.text + "/=",
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.only(top: 20),
                                           child: Container(
                                             color: Colors.white,
                                             height: 70,
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("TRANSPORT",
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                                 ),
                                                 Text("Rs: " + transport.text + "/=",
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.only(top: 20),
                                           child: Container(
                                             color: Colors.white,
                                             height: 70,
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("ACCOMONDATION",
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                                 ),
                                                 Text("Rs: " + accomondation.text + "/=",
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.only(top: 20),
                                           child: Container(
                                             color: Colors.white,
                                             height: 70,
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("OTHERS",
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                                 ),
                                                 Text("Rs: " + others.text + "/=",
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.bold,
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
                               SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                               ],
                         )
                       ], 
                     ),
                   ),
                 )
               ],
             ),
           )
         ],
       ),
     )
    );
  }
}