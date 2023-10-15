import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../provider/user_provider.dart';
import '../view/chat_view.dart';
import '../view/home_view.dart';
import '../view/login_view.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final userState = ref.watch(userProvider);
  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: HomeView.routeName,
        path: HomeView.routePath,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView(title: 'Home',);
        },
      ),
      GoRoute(
        name: LoginView.routeName,
        path: LoginView.routePath,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
      GoRoute(
        name: ChatView.routeName,
        path: ChatView.routePath,
        builder: (BuildContext context, GoRouterState state) {
          return const ChatView();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final isAuth = userState.valueOrNull != null;
      if (isAuth) {
        return HomeView.routePath;
      } else {
        return LoginView.routePath;
      }
    },
  );
});