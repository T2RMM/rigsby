import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../view/login_view.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: <RouteBase>[
      // 最初に表示されるページ.
      GoRoute(
        path: '/', // トップレベルのパスが必要なので指定する.
        name: RootView.path, // 名前付きルートを指定する.
        builder: (BuildContext context, GoRouterState state) {
          return const RootView(title: 'Root',);
        },
        // ネストしたルートを指定する.
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            name: LoginView.path,
            builder: (BuildContext context, GoRouterState state) {
              return const LoginView();
            },
          ),
        ],
      ),
    ],
  );
});