import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPage'),
      ),
      body: const SizedBox(
        width: double.infinity,
        child: Column(
              children: [
                Text('MyPage', style: TextStyle(fontSize: 32.0)),
                SignOutButton(),
              ]
        )
      )
    );
  }
}