import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

late String tripId;
User? loggedInUser = FirebaseAuth.instance.currentUser;
String _firstName = '';
String _lastName = '';

class JoinedChatScreen extends StatefulWidget {
  final String tid;
  const JoinedChatScreen({Key? key, required this.tid}) : super(key: key);

  @override
  _JoinedChatScreenState createState() => _JoinedChatScreenState();
}

class _JoinedChatScreenState extends State<JoinedChatScreen> {

final messageTextController = TextEditingController();

  late String messageText;
  late String getMessages;
  late String senderMail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    tripId = widget.tid;

    FirebaseFirestore.instance
        .collection('userInformation')
        .doc(loggedInUser!.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        _firstName = userData.data()!['firstName'];
        _lastName = userData.data()!['lastName'];
      });
    });
    print(loggedInUser!.email);
    print(_firstName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Flexible(
            child: MessageStream(),
            ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter the message",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                  controller: messageTextController,
                  onChanged: (value) {
                    messageText = value;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              TextButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('chat').add({
                      'text': messageText,
                      'sender': loggedInUser!.email,
                      'tripId': widget.tid,
                      "time": DateTime.now(),
                      "firstName": _firstName,
                      "lastName": _lastName
                    });
                    messageTextController.clear();
                  },
                  child: Text("Send"))
            ],
          )
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
             StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chat')
                    .where('tripId', isEqualTo: tripId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                    ));
                  }
                  final messages = snapshot.data!.docs.reversed;
                  List<MessageBubble> messageBubbles = [];
                  for (var message in messages) {
                    final messageText = message['text'];
                    final messageSender = message['sender'];
                    final messageTime = message["time"];
                    final senderFName = message['firstName'];
                    final senderLName = message['lastName'];

                    final currentUser = loggedInUser!.email;

                    final messageBubble = MessageBubble(
                      sender: messageSender, 
                      text: messageText,
                      time: messageTime,
                      isMe: currentUser == messageSender,
                      fName: senderFName,
                      lName: senderLName,
                      );
                    messageBubbles.add(messageBubble);
                    messageBubbles.sort((a , b ) => b.time.compareTo(a.time));
                  }
                  return ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: messageBubbles
                    );
                });
  }
}

class MessageBubble extends StatelessWidget {

  MessageBubble({required this.sender, required this.text, required this.isMe, required this.time, required this.fName, required this.lName});

  final String sender;
  final String fName;
  final String lName;
  final String text;
  final bool isMe;
  final Timestamp time;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(fName + " " + lName,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe ? BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ) : BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                                '$text',
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black54,
                                  fontSize: 15.0
                                  ),
                              ),
            ),
          ),
        ],
      ),
    );
  }
}