import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_model.dart';

abstract class UserRepository {
  Future<List<User>> retrieveUsers();
  Future<String> createUser({required User user});
  Future<void> updateUser({required User user});
  Future<void> deleteUser({required String uid});
}

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) => UserRepositoryImpl(ref));

class UserRepositoryImpl implements UserRepository {
  final Ref _ref;
  const UserRepositoryImpl(this._ref);

  @override
  Future<List<User>> retrieveUsers() async {
    try {
      final snap = await _ref.read(firebaseFirestoreProvider).collection('users').get();
      return snap.docs.map((doc) => User.fromDocument(doc)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<String> createUser({
    required User user,
  }) async {
    try {
      final docRef = await _ref.read(firebaseFirestoreProvider).collection('users').add(user.toDocument(),);
      return docRef.id;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> updateUser({required User user}) async {
    try {
      await _ref.read(firebaseFirestoreProvider)
          .collection('users')
          .doc(user.uid)
          .update(user.toDocument());
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteUser({required String uid,}) async {
    try {
      await _ref.read(firebaseFirestoreProvider)
          .collection('user')
          .doc(uid)
          .delete();
    } catch (e) {
      throw e.toString();
    }
  }
}