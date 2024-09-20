import 'dart:developer' show log;

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart' show XFile;

Future<String> scanText(XFile xFile) async {
  String result = '';
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  try {
    final InputImage inputImage = InputImage.fromFilePath(xFile.path);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    result = recognizedText.text.split('\n').first;
  } on Exception catch (e) {
    log(e.toString());
  } finally {
    textRecognizer.close();
  }

  return result;
}
