import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/constant/app_color.dart';
import '../../common/enum/upload_type.dart';
import '../../common/util/extension/build_context_extension.dart';
import '../../common/util/platform/app_platform.dart';
import '../../router/routes.dart';
import '../bloc/main_color_index/main_color_index_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.local.appTitle),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<MainColorIndexBloc>().add(UpdateMainColorIndex()),
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
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await onAddFile(context),
        child: const Icon(Icons.add),
      ),
    );
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
    // TODO: Scan xFile!
  }
}
