import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/room_model.dart';

abstract class RoomRepository {
  Future<List<Room>> retrieveRooms();
  Future<String> createRoom({required Room room});
  Future<void> updateRoom({required Room room});
  Future<void> deleteRoom({required String id});
}

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final roomRepositoryProvider = Provider<RoomRepositoryImpl>((ref) => RoomRepositoryImpl(ref));

class RoomRepositoryImpl implements RoomRepository {
  final Ref _ref;
  const RoomRepositoryImpl(this._ref);

  @override
  Future<List<Room>> retrieveRooms() async {
    try {
      final snap = await _ref.read(firebaseFirestoreProvider).collection('rooms').get();
      return snap.docs.map((doc) => Room.fromDocument(doc)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<String> createRoom({
    required Room room,
  }) async {
    try {
      final docRef = await _ref.read(firebaseFirestoreProvider).collection('rooms').add(room.toDocument(),);
      return docRef.id;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> updateRoom({required Room room}) async {
    try {
      await _ref.read(firebaseFirestoreProvider)
          .collection('rooms')
          .doc(room.id)
          .update(room.toDocument());
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteRoom({required String id,}) async {
    try {
      await _ref.read(firebaseFirestoreProvider)
          .collection('rooms')
          .doc(id)
          .delete();
    } catch (e) {
      throw e.toString();
    }
  }
}