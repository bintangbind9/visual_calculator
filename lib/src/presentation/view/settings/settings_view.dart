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
import '../../widget/custom_option_item.dart';
import '../../widget/general_section.dart';

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
            GeneralSection(
              name: context.local.theme,
              content: BlocBuilder<ThemeModeBloc, ThemeMode>(
                builder: (context, themeMode) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CustomOptionItem(
                          isTextExpanded: true,
                          text: context.local.system,
                          icon: Icons.settings,
                          isSelected: themeMode == ThemeMode.system,
                          onTap: () async {
                            if (themeMode == ThemeMode.system) return;
                            await updateThemeMode(context, ThemeMode.system);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomOptionItem(
                          isTextExpanded: true,
                          text: context.local.light,
                          icon: Icons.light_mode,
                          isSelected: themeMode == ThemeMode.light,
                          onTap: () async {
                            if (themeMode == ThemeMode.light) return;
                            await updateThemeMode(context, ThemeMode.light);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomOptionItem(
                          isTextExpanded: true,
                          text: context.local.dark,
                          icon: Icons.dark_mode,
                          isSelected: themeMode == ThemeMode.dark,
                          onTap: () async {
                            if (themeMode == ThemeMode.dark) return;
                            await updateThemeMode(context, ThemeMode.dark);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            GeneralSection(
              name: context.local.language,
              content: BlocBuilder<LocaleBloc, Locale>(
                builder: (context, locale) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CustomOptionItem(
                          isTextExpanded: true,
                          text: context.local.english,
                          isSelected: locale.languageCode == 'en',
                          onTap: () async {
                            if (locale.languageCode == 'en') return;
                            await updateLocale(context, const Locale('en'));
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomOptionItem(
                          isTextExpanded: true,
                          text: context.local.indonesian,
                          isSelected: locale.languageCode == 'id',
                          onTap: () async {
                            if (locale.languageCode == 'id') return;
                            await updateLocale(context, const Locale('id'));
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            GeneralSection(
              name: context.local.storageType,
              content: BlocBuilder<StorageTypeBloc, StorageType>(
                builder: (context, storageType) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CustomOptionItem(
                          isTextExpanded: true,
                          text: context.local.databaseStorage,
                          isSelected: storageType == StorageType.database,
                          onTap: () async {
                            if (storageType == StorageType.database) return;
                            await updateStorageType(
                              context,
                              StorageType.database,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomOptionItem(
                          isTextExpanded: true,
                          text: context.local.fileStorage,
                          isSelected: storageType == StorageType.file,
                          onTap: () async {
                            if (storageType == StorageType.file) return;
                            await updateStorageType(context, StorageType.file);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
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

  Future<void> updateThemeMode(
    BuildContext context,
    ThemeMode newThemeMode,
  ) async {
    context.read<ThemeModeBloc>().add(UpdateThemeMode(themeMode: newThemeMode));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppConstant.sharedPreferencesThemeMode,
      newThemeMode.name,
    );
  }

  Future<void> updateLocale(BuildContext context, Locale newLocale) async {
    context.read<LocaleBloc>().add(UpdateLocale(locale: newLocale));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppConstant.sharedPreferencesLanguageCode,
      newLocale.languageCode,
    );
  }

  Future<void> updateStorageType(
    BuildContext context,
    StorageType newStorageType,
  ) async {
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
      setCalculationHistories(context, calculationHistories.toList());
    }
  }
}
