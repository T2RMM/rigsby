import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/user_provider.dart';

class MyPageView extends ConsumerWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(userProvider.select(
          (value) => value.valueOrNull?.uid,
    ));
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPage'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
              children: [
                Text("$uid", style: TextStyle(fontSize: 32.0)),
                SignOutButton(),
              ]
        )
      )
    );
  }
}