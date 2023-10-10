import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUser = Provider<User>((ref) => throw UnimplementedError());

final userProvider = StreamProvider<User?>((ref) async* {
  final auth = FirebaseAuth.instance;
  final userStream = auth.authStateChanges();
  await for (final user in userStream) {
    yield user;
  }
});
