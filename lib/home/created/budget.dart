import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Budget extends StatefulWidget {
final String tripId;
  const Budget({ Key? key, required this.tripId}) : super(key: key);
  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController lastTotal = TextEditingController();
  TextEditingController lastFood = TextEditingController();
  TextEditingController lastTransport = TextEditingController();
  TextEditingController lastDrinks = TextEditingController();
  TextEditingController lastOthers = TextEditingController();
  TextEditingController lastAccomondation = TextEditingController();

  late String food;
  late String transport;
  late String accomondation;
  late String drinks;
  late String others;
  late String total;

  int _food = 0;
  int _transport = 0;
  int _accomondation = 0;
  int _drinks = 0;
  int _others = 0;
  int _total = 0;

  void _getdata() async {
  User? user = _firebaseAuth.currentUser;
  FirebaseFirestore.instance
    .collection('budget')
    .doc(widget.tripId)
    .snapshots()
    .listen((userData) {
 
    setState(() {
      lastFood.text = userData.data()!['food'];
      lastDrinks.text = userData.data()!['drinks'];
      lastAccomondation.text = userData.data()!['accomondation'];
      lastTransport.text = userData.data()!['transport'];
      lastOthers.text = userData.data()!['others'];
      lastTotal.text = userData.data()!['total'];      
    });
    });
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    if (lastFood.text == "") {
      _food = 0;
    }else{
      _food = int.parse(lastFood.text);
    }
    if (lastDrinks.text == "") {
      _drinks = 0;
    }else{
       _drinks = int.parse(lastDrinks.text);
    }
    if (lastAccomondation.text == "") {
      _accomondation = 0;
    }else{
       _accomondation = int.parse(lastAccomondation.text);
    }
    if (lastTransport.text == "") {
      _transport = 0;
    }else{
       _transport = int.parse(lastTransport.text);
    }
    if (lastOthers.text == "") {
      _others = 0;
    }else{
       _others = int.parse(lastOthers.text);
    }
    if (lastTotal.text == "" || lastTotal.text=="0") {
      _total = 0;
    }else{
       _total = int.parse(lastTotal.text);
    }
    
      _total = int.parse(lastTotal.text);
    _total = _food + _transport + _accomondation + _others + _drinks;
    total = _total.toString();
    lastTotal.text = total;
      
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("BUDGET"),
      // ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Colors.white,
                ]),
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            }, 
                            icon: Icon(Icons.arrow_back_sharp,
                            color: Colors.white,
                            ),
                            ),
                            Text("BUDGET",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                            ),
                            Icon(Icons.arrow_right_alt_rounded,
                            color: Colors.blue,
                            )
                        ],
                      ),
                    ),
                    Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "TOTAL",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.4,
                      // child: TextFormField(
                      //   enableInteractiveSelection: false,
                      //   focusNode: new AlwaysDisabledFocusNode(),
                      //   controller: lastTotal,

                      //   keyboardType: TextInputType.number,
                      //   inputFormatters: <TextInputFormatter>[
                      //     FilteringTextInputFormatter.digitsOnly
                      //   ],
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      //   decoration: InputDecoration(
                      //     hintText: "0.00",
                      //     border: OutlineInputBorder(),
                      //   ),
                      // ),
                       Text(lastTotal.text + "/=",
                       style: TextStyle(
                         fontSize: 40,
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                       ),
                       ),
                    //),
                  //),
                ],
              ),
                  ],
                ),
               // color: Colors.,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Container(
              //       color: Colors.black12,
              //       child: Text("STATEMENT"),
              //     ),
              //     Container(
              //       color: Colors.black12,
              //       child: Text("RS/="),
              //     )
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("FOOD"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: lastFood,
                            onChanged: (value) {
                              if (value != "") {
                                setState(() {
                                  food = value;
                                  _food = int.parse(food);
                                });
                              } else {
                                setState(() {
                                  value = '0';
                                  _food = int.parse(value);
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: "0.00",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("TRANSPORT"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: lastTransport,
                            onChanged: (value) {
                              if (value != "") {
                                setState(() {
                                  transport = value;
                                  _transport = int.parse(transport);
                                });
                              } else {
                                setState(() {
                                  value = '0';
                                  _transport = int.parse(value);
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: "0.00",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("ACCOMONDATION"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: lastAccomondation,
                            onChanged: (value) {
                              if (value != "") {
                                setState(() {
                                  accomondation = value;
                                  _accomondation = int.parse(accomondation);
                                });
                              } else {
                                setState(() {
                                  value = '0';
                                  _accomondation = int.parse(value);
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: "0.00",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("DRINKS"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: lastDrinks,
                            onChanged: (value) {
                              if (value != "") {
                                setState(() {
                                  drinks = value;
                                  _drinks = int.parse(drinks);
                                });
                              } else {
                                setState(() {
                                  value = '0';
                                  _drinks = int.parse(value);
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: "0.00",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("OTHERS"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: lastOthers,
                            onChanged: (value) {
                              if (value != "") {
                                setState(() {
                                  others = value;
                                  _others = int.parse(others);
                                });
                              } else {
                                setState(() {
                                  value = '0';
                                  _others = int.parse(value);
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: "0.00",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              
              Container(
                // height: MediaQuery.of(context).size.height * 0.10,
                // color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height* 0.08,
                        child: FlatButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                        child: Icon(Icons.arrow_back,
                        color: Colors.blue,
                        )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height* 0.08,
                        child: FlatButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                                        .collection('budget')
                                                        .doc(widget.tripId)
                                                        .update({
                                              "food": lastFood.text,
                                              "transport": lastTransport.text,
                                              "drinks": lastDrinks.text,
                                              "accomondation": lastAccomondation.text,
                                              "others": lastOthers.text,
                                              "total": lastTotal.text,
                                            });
                              Navigator.pop(context);
                          }, 
                        child: Text("SAVE",
                        style: TextStyle(
                          color: Colors.white
                        ),
                        )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //SizedBox(height: MediaQuery.of(context).size.height * 0.05,)
            ],
          ),
        ),
      ),
    );
    
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
