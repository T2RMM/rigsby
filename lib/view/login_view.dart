import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'home_view.dart';


class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);
  static String get routeName => 'login';
  static String get routePath => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SignInScreen(
      auth: FirebaseAuth.instance,
      providers: [EmailAuthProvider()],
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          debugPrint("Signed in");
          context.go(HomeView.routePath);
        }),
      ],
    );
  }
}

// onPressed: () {
// isUpdating
// ? itemListNotifier.updateItem(
// // データの更新
// updatedItem: item.copyWith(
// title: textController.text.trim(),
// ),
// )
//     : itemListNotifier.addItem(
// // データの追加
// title: textController.text.trim(),
// );
// Navigator.of(context).pop();
