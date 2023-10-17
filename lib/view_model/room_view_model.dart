

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/room_model.dart';
import '../repository/room_repository.dart';

final roomListProvider = StateNotifierProvider<RoomListNotifier, AsyncValue<List<Room>>>((ref) {
  return RoomListNotifier(ref);
});

class RoomListNotifier extends StateNotifier<AsyncValue<List<Room>>> {
  final Ref _ref;
  RoomListNotifier(this._ref) : super(const AsyncValue.loading()) {
    retrieveRooms();
  }

  Future<void> retrieveRooms({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();
    try {
      final rooms = await _ref.read(roomRepositoryProvider).retrieveRooms();
      if (mounted) {
        state = AsyncValue.data(rooms);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // required String id,
  // required List<Message> messages,

  Future<void> addRoom() async {
    try {
      final room = Room(
        messages: [],
      );
      final roomId = await _ref.read(roomRepositoryProvider).createRoom(room: room);
      state.whenData((rooms) => state = AsyncValue.data(
        rooms..add(room.copyWith(id: roomId)),),
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateRoom({required Room updatedRoom}) async {
    try {
      await _ref.read(roomRepositoryProvider).updateRoom(room: updatedRoom);
      state.whenData((rooms) {
        state = AsyncValue.data([
          for (final room in rooms)
            if (room.id == updatedRoom.id) updatedRoom else room
        ]);
      },
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteRoom({required String roomId}) async {
    try {
      await _ref.read(roomRepositoryProvider).deleteRoom(id: roomId);
      state.whenData((rooms) => state = AsyncValue.data(
          rooms..removeWhere((room) => room.id == roomId),
        ),
      );
    } catch (e) {
      throw e.toString();
    }
  }
}