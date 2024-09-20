import 'package:flutter/material.dart' show Icons, IconData, BuildContext;

import '../util/extension/build_context_extension.dart';

enum UploadType {
  gallery,
  camera,
  file,
}

const Map<UploadType, IconData> uploadTypeIcons = {
  UploadType.gallery: Icons.image,
  UploadType.camera: Icons.camera_alt,
  UploadType.file: Icons.folder,
};

String getUploadTypeName(
  BuildContext context,
  UploadType uploadType,
) {
  switch (uploadType) {
    case UploadType.gallery:
      return context.local.gallery;
    case UploadType.camera:
      return context.local.camera;
    case UploadType.file:
      return context.local.file;
    default:
      return context.local.other;
  }
}
