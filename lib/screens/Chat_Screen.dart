import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymessage/screens/Welcome_Screen.dart';

final _firestore = FirebaseFirestore.instance;
late User signInUser;
final _auth = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  //const ChatScreen({Key? key}) : super(key: key);
  static const String chatScreen = '/chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  String? messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signInUser = user;
        //print(signInUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   messages.docs.forEach((message) {
  //     print(message.data());
  //   });
  // }
  // void getMessages() async {
  //   await _firestore.collection('messages').snapshots().forEach((snapshot) {
  //     snapshot.docs.forEach((message) {
  //       print(message.data());
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pink[50],
        title: Row(
          children: [
            Image.asset(
              'images/Logo2.png',
              height: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'MessageMe',
              style: TextStyle(
                color: Color.fromRGBO(241, 120, 107, 1),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              //getMessages();
              _auth.signOut();
              // Navigator.of(context).pushNamed(WelcomeScreen.welcomeScreen);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
            color: const Color.fromRGBO(241, 120, 107, 1),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStreamBuilder(),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.pink, width: 2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      onEditingComplete: () {},
                      textInputAction: TextInputAction.send,
                      onSubmitted: (value) {
                        messageTextController.clear();
                        _firestore.collection('messages').add(
                          {
                            'text': messageText,
                            'sender': signInUser.email,
                            'time': FieldValue.serverTimestamp(),
                          },
                        );
                      },
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here ..',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add(
                        {
                          'text': messageText,
                          'sender': signInUser.email,
                          'time': FieldValue.serverTimestamp(),
                        },
                      );
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messageWidgets = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        snapshot.data!.docs.reversed.forEach(
          (message) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final currentUser = signInUser.email;
            messageWidgets.add(
              MessageLine(
                text: messageText,
                sender: messageSender,
                isMe: currentUser == messageSender,
              ),
            );
          },
        );
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  MessageLine({Key? key, this.text, this.sender, required this.isMe})
      : super(key: key);
  final String? text;
  final String? sender;
  bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            '$sender',
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
          Material(
            elevation: 5,
            borderRadius: border(),
            color: isMe ? Colors.pink : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 20,
                  color: isMe ? Colors.white : Colors.pink,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius border() {
    return isMe
        ? const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          );
  }
}
