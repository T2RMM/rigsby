import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rigsby/router/router.dart';
import 'package:rigsby/view/message_view.dart';
import 'package:rigsby/view/mypage_view.dart';
import 'package:rigsby/view/search_view.dart';

Future<void> main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      title: 'Rigsby',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class RouteView extends StatefulWidget {
  const RouteView({super.key, required this.title});
  final String title;

  @override
  State<RouteView> createState() => _RouteViewState();
}

class _RouteViewState extends State<RouteView> {
  static const _screens = [
    SearchView(),
    MessageView(),
    MyPageView(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? currentUser) {
      if (currentUser == null) {
        goRouter.go(context as String, extra: '/login');
      }
      else {
        FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.uid)
            .get()
            .then((DocumentSnapshot result) =>
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const SearchView())))
            .catchError((err) => print(err));
      }
    });
    super.initState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'さがす'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'メッセージ'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}