import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MessageView extends StatelessWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: SafeArea(
        child: ListView(children: <Widget>[
          ListTile(
            leading: const CircleAvatar(),
            trailing: const Text('3分前'),
            title: const Text('bird'),
            subtitle: const Text('こんにちは'),
            onTap: () => context.push('/chat/room3'),
          )
        ]),
      ),
    );
  }
}
