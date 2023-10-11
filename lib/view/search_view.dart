import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../provider/user_provider.dart';
import '../view_model/search_view_model.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final UserState userState = Provider.of<UserState>(context);
    // final User user = userState.user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: const SearchViewModel()
    );
  }
}