import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

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
abstract class Message with _$Message {
  const Message._();
  factory Message({
    required String senderid,
    required String message,
    @DateTimeTimestampConverter() required DateTime createdAt,
  }) = _Message;

  factory Message.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Message.fromJson(data).copyWith(senderid: doc.id);
  }
  Map<String, dynamic> toDocument() => toJson()..remove('id');
  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}