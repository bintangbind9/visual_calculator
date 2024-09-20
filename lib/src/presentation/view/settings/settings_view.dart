import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/util/extension/build_context_extension.dart';
import '../../bloc/locale/locale_bloc.dart';
import '../../bloc/theme_mode/theme_mode_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.local.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<ThemeModeBloc, ThemeMode>(
              builder: (context, themeMode) {
                return DropdownButton<ThemeMode>(
                  isExpanded: true,
                  value: themeMode,
                  onChanged: (newThemeMode) {
                    if (newThemeMode == null) return;
                    if (themeMode == newThemeMode) return;
                    context
                        .read<ThemeModeBloc>()
                        .add(UpdateThemeMode(themeMode: newThemeMode));
                  },
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
                );
              },
            ),
            BlocBuilder<LocaleBloc, Locale>(
              builder: (context, locale) {
                return DropdownButton<Locale>(
                  isExpanded: true,
                  value: locale,
                  onChanged: (newLocale) {
                    if (newLocale == null) return;
                    if (locale.languageCode == newLocale.languageCode) return;
                    context
                        .read<LocaleBloc>()
                        .add(UpdateLocale(locale: newLocale));
                  },
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
