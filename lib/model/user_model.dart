class UserModel {
  String uid;
  String email;
  String displayName;
  DateTime updatedAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(uid: data['uid'], email: data['email'], displayName: data['displayName'], updatedAt: data['updatedAt']);
  }
}