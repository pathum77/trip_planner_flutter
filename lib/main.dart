import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/home/create/test.dart';
import 'package:trip_planner/home/created/participantEditView.dart';
import 'package:trip_planner/home/join/joinTripId.dart';
import 'package:trip_planner/home/joinned/JoinedReturnScreens/chat.dart';
import 'package:trip_planner/home/newHome.dart';
import 'package:trip_planner/login/UserInfo/InsertUser.dart';
import 'package:trip_planner/login/UserInfo/editUserInfo.dart';
import 'package:trip_planner/login/newRegister.dart';
import 'package:trip_planner/login/userInfo.dart';
import 'package:trip_planner/splash/splash.dart';

void main()async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
 runApp(MyApp(),
); 
}

// void main()async{
// WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();
//  runApp(
//    DevicePreview(
//        builder: (context) =>
//        MyApp(),
//     ),
// );
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
