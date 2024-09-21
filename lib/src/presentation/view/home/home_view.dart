import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constant/app_color.dart';
import '../../../common/constant/app_constant.dart';
import '../../../common/enum/upload_type.dart';
import '../../../common/exception/database_exception.dart';
import '../../../common/util/calculator/calculator.dart';
import '../../../common/util/dialog/info_dialog.dart';
import '../../../common/util/extension/build_context_extension.dart';
import '../../../common/util/overlay/loading/loading_screen.dart';
import '../../../common/util/platform/app_platform.dart';
import '../../../common/util/text_recognition/text_recognition.dart';
import '../../../domain/entity/calculation_history.dart';
import '../../../domain/usecase/calculation_history/create_calculation_history_use_case.dart';
import '../../../domain/usecase/calculation_history/delete_calculation_history_use_case.dart';
import '../../../router/routes.dart';
import '../../bloc/calculation_history/calculation_history_bloc.dart';
import '../../bloc/main_color_index/main_color_index_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainColorIndexBloc, int>(
      listener: (context, mainColorIndex) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(
          AppConstant.sharedPreferencesMainColorIndex,
          mainColorIndex,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.local.appTitle),
          actions: [
            IconButton(
              onPressed: () async => context
                  .read<MainColorIndexBloc>()
                  .add(UpdateMainColorIndex()),
              icon: BlocBuilder<MainColorIndexBloc, int>(
                builder: (context, index) {
                  return Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColor.mainColors[index],
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () => context.goNamed(Routes.settings),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<CalculationHistoryBloc, CalculationHistoryState>(
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: state.calculationHistories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final calculationHistory = state.calculationHistories[index];

                  return Dismissible(
                    key: Key('CalculationHistoryId${calculationHistory.id}'),
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Colors.red,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    onDismissed: (direction) async {
                      final deleteCalculationHistoryUseCase =
                          GetIt.I<DeleteCalculationHistoryUseCase>();
                      await deleteCalculationHistoryUseCase
                          .call(calculationHistory.id);

                      if (context.mounted) {
                        context.read<CalculationHistoryBloc>().add(
                            RemoveCalculationHistory(
                                calculationHistory: calculationHistory));
                      }
                    },
                    child: ListTile(
                      title: Text(
                        calculationHistory.expression,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        '= ${calculationHistory.result}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await onAddFile(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void addCalculationHistory(
    BuildContext context,
    CalculationHistory calculationHistory,
  ) {
    context
        .read<CalculationHistoryBloc>()
        .add(AddCalculationHistory(calculationHistory: calculationHistory));
  }

  Future<void> onAddFile(BuildContext context) async {
    late UploadType uploadType;

    if (getCurrentPlatform == AppPlatform.web) {
      uploadType = UploadType.file;
    } else {
      final selectedUploadType = await showModalBottomSheet<UploadType>(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: UploadType.values.map((uploadType) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(uploadType),
                      child: Text(getUploadTypeName(context, uploadType)),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      );

      if (selectedUploadType == null) return;
      uploadType = selectedUploadType;
    }

    XFile? xFile;

    switch (uploadType) {
      case UploadType.gallery:
        xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        break;
      case UploadType.camera:
        xFile = await ImagePicker().pickImage(source: ImageSource.camera);
        break;
      case UploadType.file:
        final filePickerResult = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.image,
        );

        if (filePickerResult == null) return;

        final xFiles = filePickerResult.xFiles;
        if (xFiles.isEmpty) return;

        xFile = xFiles.first;
        break;
    }

    if (xFile == null) return;
    String text = '';

    try {
      if (!context.mounted) return;

      GetIt.I<LoadingScreen>().show(
        context: context,
        text: context.local.loading,
      );

      text = await scanText(xFile);
      text = text.trim();

      final calculator = GetIt.I<Calculator>();
      final result = calculator.evaluate(text);

      final createCalculationHistoryUseCase =
          GetIt.I<CreateCalculationHistoryUseCase>();
      final calculationHistory = await createCalculationHistoryUseCase.call(
        CalculationHistory(
          expression: text,
          result: result,
        ),
      );

      if (!context.mounted) throw CouldNotCreateCalculationHistoryException();
      addCalculationHistory(context, calculationHistory);
    } on CouldNotCreateCalculationHistoryException catch (_) {
      if (context.mounted) {
        showInfoDialog(context, context.local.couldNotCreateCalculationHistory);
      }
    } on FormatException catch (e) {
      log(e.toString());
      if (context.mounted) {
        showInfoDialog(
            context,
            text.isEmpty
                ? context.local.textDetectedIsEmpty
                : context.local.textDetectedIsInvalid(text));
      }
    } on StateError catch (e) {
      log(e.toString());
      if (context.mounted) {
        showInfoDialog(context, context.local.textDetectedIsInvalid(text));
      }
    } catch (e) {
      log(e.toString());
      if (context.mounted) showInfoDialog(context, e.toString());
    } finally {
      GetIt.I<LoadingScreen>().hide();
    }
  }
}
