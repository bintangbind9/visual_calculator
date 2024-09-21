import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constant/app_constant.dart';
import '../../../common/enum/storage_type.dart';
import '../../../common/service_locator/locator.dart';
import '../../../common/util/extension/build_context_extension.dart';
import '../../../domain/entity/calculation_history.dart';
import '../../../domain/usecase/calculation_history/get_all_calculation_history_use_case.dart';
import '../../bloc/calculation_history/calculation_history_bloc.dart';
import '../../bloc/locale/locale_bloc.dart';
import '../../bloc/storage_type/storage_type_bloc.dart';
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
                  onChanged: (newThemeMode) async {
                    if (newThemeMode == null) return;
                    if (themeMode == newThemeMode) return;
                    context
                        .read<ThemeModeBloc>()
                        .add(UpdateThemeMode(themeMode: newThemeMode));

                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                      AppConstant.sharedPreferencesThemeMode,
                      newThemeMode.name,
                    );
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
                  onChanged: (newLocale) async {
                    if (newLocale == null) return;
                    if (locale.languageCode == newLocale.languageCode) return;
                    context
                        .read<LocaleBloc>()
                        .add(UpdateLocale(locale: newLocale));

                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                      AppConstant.sharedPreferencesLanguageCode,
                      newLocale.languageCode,
                    );
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
            BlocBuilder<StorageTypeBloc, StorageType>(
              builder: (context, storageType) {
                return DropdownButton<StorageType>(
                  isExpanded: true,
                  value: storageType,
                  onChanged: (newStorageType) async {
                    if (newStorageType == null) return;
                    if (storageType == newStorageType) return;
                    context
                        .read<StorageTypeBloc>()
                        .add(UpdateStorageType(storageType: newStorageType));

                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                      AppConstant.sharedPreferencesStorageType,
                      newStorageType.name,
                    );

                    switch (newStorageType) {
                      case StorageType.database:
                        await setupLocatorStorageTypeDatabase();
                        await setupLocatorCalculationHistoryUseCase();
                        break;
                      case StorageType.file:
                        await setupLocatorStorageTypeFile();
                        await setupLocatorCalculationHistoryUseCase();
                        break;
                    }

                    final getAllCalculationHistoryUseCase =
                        GetIt.I<GetAllCalculationHistoryUseCase>();
                    final calculationHistories =
                        await getAllCalculationHistoryUseCase.call(null);
                    if (context.mounted) {
                      setCalculationHistories(
                          context, calculationHistories.toList());
                    }
                  },
                  items: [
                    DropdownMenuItem(
                      value: StorageType.database,
                      child: Text(context.local.databaseStorage),
                    ),
                    DropdownMenuItem(
                      value: StorageType.file,
                      child: Text(context.local.fileStorage),
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

  void setCalculationHistories(
    BuildContext context,
    List<CalculationHistory> calculationHistories,
  ) {
    context
        .read<CalculationHistoryBloc>()
        .add(SetCalculationHistory(calculationHistories: calculationHistories));
  }
}
