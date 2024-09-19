import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/home/home_view.dart';
import '../presentation/settings/settings_controller.dart';
import '../presentation/settings/settings_view.dart';
import 'routes.dart';

class Router {
  final SettingsController settingsController;
  late GoRouter _router;

  Router({
    required this.settingsController,
  }) {
    GoRouter(
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
                return SettingsView(controller: settingsController);
              },
            ),
          ],
        ),
      ],
    );
  }

  GoRouter get router => _router;
}
