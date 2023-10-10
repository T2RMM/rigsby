import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rigsby/view/search_view.dart';

import 'message_view.dart';
import 'mypage_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});
  static String get routeName => 'home';
  static String get routePath => '/';
  final String title;

  @override
  State<HomeView> createState() => _RootViewState();
}

class _RootViewState extends State<HomeView> {
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded), label: 'さがす'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'メッセージ'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}