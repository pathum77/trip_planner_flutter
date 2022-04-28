import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/login/UserInfo/InsertUser.dart';

class NewLogin extends StatefulWidget {
  const NewLogin({Key? key}) : super(key: key);

  @override
  _NewLoginState createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {

  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue,
                Colors.white,
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: 70,
                height: 70,
                child: Image.asset("assets/splashScreen.png"),
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue[400]),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail,
                      color: Colors.white,
                      ),
                      suffixIcon: Icon(
                        Icons.mail,
                        color: Colors.blue[400],
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.blue[400],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onChanged: (value){
                      email = value;
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    style: TextStyle(color: Colors.blue[400]),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock,
                      color: Colors.white,
                      ),
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.blue[400],
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.blue[400],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onChanged: (value){
                      password = value;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 100),
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      try{
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if(newUser != null){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => InsertUserInfo()));
                      }
                      } catch(e){
                        print(e);
                      }
                    },
                    child: Text("REGISTER",
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  child: Text("Already have an account?",
                  style: TextStyle(
                    color: Colors.blue
                  ),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.blue,
                    width: 1
                  ),
                  ),
                  child: FlatButton(
                    onPressed: (){}, 
                    child: Text("Log In",
                    style: TextStyle(
                      color: Colors.blue
                    ),
                    ),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
