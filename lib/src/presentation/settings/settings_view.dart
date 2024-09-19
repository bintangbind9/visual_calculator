import 'package:flutter/material.dart';

import '../../common/util/extension/build_context_extension.dart';
import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.local.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton<ThemeMode>(
              isExpanded: true,
              // Read the selected themeMode from the controller
              value: controller.themeMode,
              // Call the updateThemeMode method any time the user selects a theme.
              onChanged: controller.updateThemeMode,
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(context.local.systemTheme),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(context.local.lightTheme),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(context.local.darkTheme),
                )
              ],
            ),
            DropdownButton<Locale>(
              isExpanded: true,
              // Read the selected locale from the controller
              value: controller.locale,
              // Call the updateLocale method any time the user selects a locale.
              onChanged: controller.updateLocale,
              items: [
                DropdownMenuItem(
                  value: const Locale('en'),
                  child: Text(context.local.english),
                ),
                DropdownMenuItem(
                  value: const Locale('in'),
                  child: Text(context.local.indonesian),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
