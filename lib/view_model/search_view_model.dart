import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rigsby/model/user_model.dart';

class SearchViewModel extends StatelessWidget {
  const SearchViewModel({super.key});

  // Streamを使用して、モデルクラスから、データを取得するメソッド
  Stream<List<UserModel>> _fetchUsersStream() {
    final firestore = FirebaseFirestore.instance;
    final userStream = firestore.collection('users').snapshots();
    return userStream.map((snapshot) =>
        snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList());
  }

  @override
  Widget build(BuildContext context) {
    // ListとPersonクラスを指定する
    return StreamBuilder<List<UserModel>>(
      // 上で定義したメソッドを使用する
      stream: _fetchUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final users = snapshot.data!;
        return ListView.builder(
          // Listのデータの数を数える
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              // Personクラスのメンバ変数を使用する
              title: Text('Name: ${user.displayName}'),
            );
          },
        );
      },
    );
  }
}