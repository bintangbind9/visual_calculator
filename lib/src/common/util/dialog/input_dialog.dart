import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/bloc/screen_size/screen_size_bloc.dart';
import '../../constant/app_constant.dart';
import '../../enum/screen_size.dart';

Future<T?> showInputDialog<T>(
  BuildContext context,
  Widget input,
  List<Widget> actions, {
  Widget? header,
  double? maxDialogWidth,
  bool barrierDismissible = true,
}) async {
  final content = Wrap(
    children: [
      header == null
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: Stack(
                children: [
                  Center(child: header),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
      Container(
        padding: const EdgeInsets.all(20),
        child: input,
      ),
      actions.isEmpty
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: actions,
              ),
            ),
    ],
  );

  return await showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return Dialog(
        child: maxDialogWidth == null
            ? BlocBuilder<ScreenSizeBloc, ScreenSize>(
                builder: (context, screenSize) {
                  late double maxWidth;
                  switch (screenSize) {
                    case ScreenSize.small:
                      maxWidth = MediaQuery.sizeOf(context).width;
                      break;
                    case ScreenSize.medium:
                      maxWidth = MediaQuery.sizeOf(context).width * .8;
                      break;
                    case ScreenSize.large:
                      maxWidth = MediaQuery.sizeOf(context).width * .6;
                      break;
                    default:
                      maxWidth = AppConstant.maxDialogWidth;
                      break;
                  }

                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: AppConstant.minDialogWidth,
                      maxWidth: maxWidth,
                    ),
                    child: content,
                  );
                },
              )
            : ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: AppConstant.minDialogWidth,
                  maxWidth: maxDialogWidth,
                ),
                child: content,
              ),
      );
    },
  );
}
