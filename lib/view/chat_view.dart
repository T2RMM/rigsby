import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/room_view_model.dart';

class ChatView extends ConsumerWidget {
  const ChatView({Key? key}) : super(key: key);
  static String get routeName => 'chat';
  static String get routePath => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('bird'),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          MessageStream(),
          messageInputWidget(),
        ],
      )),
    );
  }

  messageInputWidget() {
    return SizedBox(
      height: 68,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            iconSize: 28,
            color: Colors.black54,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.photo_outlined),
            iconSize: 28,
            color: Colors.black54,
            onPressed: () {},
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.8),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(40)),
                child: const TextField(
                  autofocus: true,
                  decoration: InputDecoration(border: InputBorder.none),
                )),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 28,
            color: Colors.black54,
            onPressed: () {}
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('rooms').doc('room3').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightGreenAccent,
            ),
          );
        }
        final messages = snapshot.data;
        List<MessageBalloon> messageBalloons = [];
        for (var message in messages?['messages']) {
          final messageText = message['message'];
          final messageSenderId = message['senderId'];

          final messageBalloon = MessageBalloon(
            sender: messageSenderId,
            text: messageText,
          );
          messageBalloons.add(messageBalloon);
        }
        return Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 32.0,
            ),
            children: messageBalloons,
          ),
        );
      },
    );
  }
}

class MessageBalloon extends StatelessWidget {
  const MessageBalloon({super.key, required this.sender, required this.text});

  final String sender;
  final String text;
  @override
  Widget build(BuildContext context) {
    return sender == 'UWUdZCvjyjcMcOFVcg8QdBbHEtN2'? rightBalloon(text) : leftBalloon(text);
  }

  rightBalloon(text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
            gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  Color.fromARGB(255, 108, 132, 235),
                  Color.fromARGB(250, 132, 199, 250),
                ],
                stops: [
                  0.0,
                  1.0,
                ]),
            color: Colors.redAccent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  leftBalloon(text) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 28.0),
        child: Row(
          children: [
            const CircleAvatar(),
            const SizedBox(width: 16.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: const Color.fromARGB(255, 233, 233, 233),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(text),
              ),
            )
          ],
        )
    );
  }
}
