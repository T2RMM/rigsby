import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rigsby/model/room_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

class DateTimeTimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const DateTimeTimestampConverter();

  @override
  DateTime fromJson(Timestamp json) {
    return json.toDate();
  }

  @override
  Timestamp toJson(DateTime object) {
    return Timestamp.fromDate(object);
  }
}

@freezed
abstract class User with _$User {
  const User._();
  factory User({
    required String uid,
    required String email,
    required String displayName,
    required List<Room> rooms,
    @DateTimeTimestampConverter() required DateTime createdAt,
  }) = _User;

  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return User.fromJson(data).copyWith(uid: doc.id);
  }
  Map<String, dynamic> toDocument() => toJson()..remove('id');
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}