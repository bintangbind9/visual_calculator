import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common/constant/app_color.dart';
import 'common/util/extension/build_context_extension.dart';
import 'presentation/bloc/locale/locale_bloc.dart';
import 'presentation/bloc/main_color_index/main_color_index_bloc.dart';
import 'presentation/bloc/theme_mode/theme_mode_bloc.dart';
import 'router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final mainColorIndex = context.watch<MainColorIndexBloc>().state;
      final locale = context.watch<LocaleBloc>().state;
      final themeMode = context.watch<ThemeModeBloc>().state;

      return MaterialApp.router(
        // Provide the generated AppLocalizations to the MaterialApp. This
        // allows descendant Widgets to display the correct translations
        // depending on the user's locale.
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,

        // Use AppLocalizations to configure the correct application title
        // depending on the user's locale.
        //
        // The appTitle is defined in .arb files found in the localization
        // directory.
        onGenerateTitle: (BuildContext context) => context.local.appTitle,

        // Define a light and dark color theme. Then, read the user's
        // preferred ThemeMode (light, dark, or system default).
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColor.mainColors[mainColorIndex],
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColor.mainColors[mainColorIndex],
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        themeMode: themeMode,

        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        routerConfig: router,
      );
    });
  }
}
