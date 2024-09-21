import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/constant/app_color.dart';
import 'common/constant/app_constant.dart';
import 'common/util/extension/build_context_extension.dart';
import 'presentation/bloc/locale/locale_bloc.dart';
import 'presentation/bloc/main_color_index/main_color_index_bloc.dart';
import 'presentation/bloc/theme_mode/theme_mode_bloc.dart';
import 'router/router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  void updateMainColorIndex(int index) {
    context.read<MainColorIndexBloc>().add(SetMainColorIndex(index: index));
  }

  void updateLanguageCode(String languageCode) {
    context.read<LocaleBloc>().add(UpdateLocale(locale: Locale(languageCode)));
  }

  void updateThemeMode(String themeModeName) {
    context.read<ThemeModeBloc>().add(
        UpdateThemeMode(themeMode: ThemeMode.values.byName(themeModeName)));
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final prefs = await SharedPreferences.getInstance();

      int? mainColorIndex =
          prefs.getInt(AppConstant.sharedPreferencesMainColorIndex);
      mainColorIndex = mainColorIndex ?? 0;
      updateMainColorIndex(mainColorIndex);

      String? languageCode =
          prefs.getString(AppConstant.sharedPreferencesLanguageCode);
      languageCode = languageCode ?? AppConstant.defaultLanguageCode;
      updateLanguageCode(languageCode);

      String? themeModeName =
          prefs.getString(AppConstant.sharedPreferencesThemeMode);
      themeModeName = themeModeName ?? ThemeMode.system.name;
      updateThemeMode(themeModeName);
    });
    super.initState();
  }

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
