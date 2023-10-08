import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../view/login_view.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: RouteView(title: 'Route',));
        }),
    GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return MaterialPage(child: LoginView());
        }),
  ],
);