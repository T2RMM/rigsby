import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: SafeArea(
        child: ListView(
            children: const <Widget>[
              ListTile(
                leading: CircleAvatar(),
                trailing: Text('3分前'),
                title: Text('bird'),
                subtitle: Text('こんにちは'),
              ),
            ]
        ),
      ),
    );
  }
}