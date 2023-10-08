import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rigsby/view/search_view.dart';

import '../provider/user_provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginView> {
  String _email = '';
  String _password = '';
  final UserState userState = UserState();

  @override
  Widget build(BuildContext context) {
    // ユーザー情報を受け取る
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /* --- 省略 --- */
              Container(
                width: double.infinity,
                // ユーザー登録ボタン
                child: ElevatedButton(
                  child: Text('ユーザー登録'),
                  onPressed: () async {
                    try {
                      // メール/パスワードでユーザー登録
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.createUserWithEmailAndPassword(
                        email: _email,
                        password: _password,
                      );
                      // ユーザー情報を更新
                      userState.setUser(result.user!);
                      // ユーザー登録に成功した場合
                      // チャット画面に遷移＋ログイン画面を破棄
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return SearchView();
                        }),
                      );
                    } catch (e) {
                      /* --- 省略 --- */
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                // ログイン登録ボタン
                child: OutlinedButton(
                  child: Text('ログイン'),
                  onPressed: () async {
                    try {
                      // メール/パスワードでログイン
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.signInWithEmailAndPassword(
                        email: _email,
                        password: _password,
                      );
                      // ユーザー情報を更新
                      userState.setUser(result.user!);
                      // ログインに成功した場合
                      // チャット画面に遷移＋ログイン画面を破棄
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return SearchView();
                        }),
                      );
                    } catch (e) {
                      /* --- 省略 --- */
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}