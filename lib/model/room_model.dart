import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'message_model.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

@freezed
abstract class Room with _$Room {
  const Room._();
  factory Room({
    String? id,
    required List<Message> messages,
  }) = _Room;

  factory Room.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Room.fromJson(data).copyWith(id: doc.id);
  }
  Map<String, dynamic> toDocument() => toJson()..remove('id');
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}