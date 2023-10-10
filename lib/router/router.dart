import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../provider/user_provider.dart';
import '../view/login_view.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final userState = ref.watch(userProvider);
  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: RootView.routeName,
        path: RootView.routePath,
        builder: (BuildContext context, GoRouterState state) {
          return const RootView(title: 'Root',);
        },
      ),
      GoRoute(
        name: LoginView.routeName,
        path: LoginView.routePath,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final isAuth = userState.valueOrNull != null;
      if (isAuth) {
        return RootView.routePath;
      } else {
        return LoginView.routePath;
      }
    },
  );
});