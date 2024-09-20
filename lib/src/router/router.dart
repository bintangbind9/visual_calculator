import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/view/home/home_view.dart';
import '../presentation/view/settings/settings_view.dart';
import 'routes.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.home,
  routes: <RouteBase>[
    GoRoute(
      name: Routes.home,
      path: Routes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
      routes: <RouteBase>[
        GoRoute(
          name: Routes.settings,
          path: Routes.settings,
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsView();
          },
        ),
      ],
    ),
  ],
);
