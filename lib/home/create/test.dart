// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({ Key? key }) : super(key: key);

//   @override
//   _TestScreenState createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {

// AnimationController controller = AnimationController(duration: Duration(seconds: 3), vsync: this);

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     AnimationController _animationController = AnimationController(
//   duration: Duration(seconds: 3),
//   vsync: this,
// );
//   }
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//     floatingActionButton: SpeedDial(
//       animatedIcon: AnimatedIcons.menu_close,
//       animatedIconTheme: IconThemeData(size: 22.0),
//       // this is ignored if animatedIcon is non null
//       // child: Icon(Icons.add),
//       //visible: _dialVisible,
//       curve: Curves.bounceIn,
//       overlayColor: Colors.black,
//       overlayOpacity: 0.5,
//       onOpen: () => print('OPENING DIAL'),
//       onClose: () => print('DIAL CLOSED'),
//       tooltip: 'Speed Dial',
//       heroTag: 'speed-dial-hero-tag',
//       backgroundColor: Colors.white,
//       foregroundColor: Colors.black,
//       elevation: 8.0,
//       shape: CircleBorder(),
//       children: [
//         SpeedDialChild(
//           child: Icon(Icons.accessibility),
//           backgroundColor: Colors.red,
//           label: 'First',
//          // labelStyle: TextTheme(fontSize: 18.0),
//           onTap: () => print('FIRST CHILD')
//         ),
//         SpeedDialChild(
//           child: Icon(Icons.brush),
//           backgroundColor: Colors.blue,
//           label: 'Second',
//           //labelStyle: TextTheme(fontSize: 18.0),
//           onTap: () => print('SECOND CHILD'),
//         ),
//         SpeedDialChild(
//           child: Icon(Icons.keyboard_voice),
//           backgroundColor: Colors.green,
//           label: 'Third',
//           //labelStyle: TextTheme(fontSize: 18.0),
//           onTap: () => print('THIRD CHILD'),
//         ),
//       ],
//     ),
// );
//   }
// }