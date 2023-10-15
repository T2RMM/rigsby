import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);
  static String get routeName => 'chat';
  static String get routePath => '/$routeName/:roomId';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('bird'),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 32.0,
              ),
              child: Column(
                children: <Widget>[
                  rightBalloon(),
                  leftBalloon(),
                ],
              ),
            ),
          ),
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
            icon: const Icon(Icons.mic),
            iconSize: 28,
            color: Colors.black54,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  rightBalloon() {
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
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'こんにちは',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ),
    );
  }

  leftBalloon() {
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
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('こんにちは'),
              ),
            )
          ],
        )
    );
  }
}
