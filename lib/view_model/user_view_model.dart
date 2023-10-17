import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/room_model.dart';
import '../model/user_model.dart';
import '../repository/user_repository.dart';

final itemListProvider = StateNotifierProvider<UserListNotifier, AsyncValue<List<User>>>((ref) {
  return UserListNotifier(ref);
});

class UserListNotifier extends StateNotifier<AsyncValue<List<User>>> {
  final Ref _ref;
  UserListNotifier(this._ref) : super(const AsyncValue.loading()) {
    retrieveUsers();
  }

  Future<void> retrieveUsers({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();
    try {
      final users = await _ref.read(userRepositoryProvider).retrieveUsers();
      if (mounted) {
        state = AsyncValue.data(users);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> addUser({
    required String uid,
    required String email,
    required String displayName,
    required List<Room> rooms,
    @DateTimeTimestampConverter() required DateTime createdAt,
  }) async {
    try {
      final user = User(
        uid: uid,
        email: email,
        displayName: displayName,
        rooms: rooms,
        createdAt: DateTime.now(),
      );
      state.whenData((users) => state = AsyncValue.data(
          users..add(user.copyWith(uid: uid)),
        ),
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateUser({required User updatedUser}) async {
    try {
      await _ref.read(userRepositoryProvider).updateUser(user: updatedUser);
      state.whenData((users) {
          state = AsyncValue.data([
            for (final user in users)
              if (user.uid == updatedUser.uid) updatedUser else user
          ]);
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteUser({required String uid}) async {
    try {
      await _ref.read(userRepositoryProvider).deleteUser(uid: uid);
      state.whenData(
            (users) => state = AsyncValue.data(
          users..removeWhere((user) => user.uid == uid),
        ),
      );
    } catch (e) {
      throw e.toString();
    }
  }
}