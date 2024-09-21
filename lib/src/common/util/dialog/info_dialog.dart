import 'package:flutter/material.dart';

import '../extension/build_context_extension.dart';
import 'generic_dialog.dart';

Future<T?> showInfoDialog<T>(
  BuildContext context,
  String text,
) async {
  return await showGenericDialog(context, text, [
    TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(context.local.ok),
    ),
  ]);
}
