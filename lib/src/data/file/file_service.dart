import 'dart:developer';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/util/encryptor/encryptor.dart';

class FileService {
  final encryptor = GetIt.I<Encryptor>();

  Future<String> get _localPath async {
    /*
    final directory = getCurrentPlatform == AppPlatform.android
        ? (await getExternalStorageDirectory() ??
            await getApplicationDocumentsDirectory())
        : await getApplicationDocumentsDirectory();
    */

    final directory = await getApplicationDocumentsDirectory();
    return directory.absolute.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<File> write(String fileName, String content) async {
    final file = await _localFile(fileName);

    // Encrypt content
    final encrypted = encryptor.encrypt(content);

    // Write the file
    return await file.writeAsString(encrypted.base64);
  }

  Future<String> read(
    String fileName, {
    String defaultContentIfNotExists = '',
  }) async {
    try {
      final file = await _localFile(fileName);

      // Read the file
      String content = await file.readAsString();

      // Decrypt content
      content = encryptor.decrypt(Encrypted.fromBase64(content));

      return content;
    } on PathNotFoundException catch (_) {
      await write(fileName, defaultContentIfNotExists);
      return await read(fileName);
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  Future<FileSystemEntity> delete(String fileName) async {
    final file = await _localFile(fileName);
    return await file.delete();
  }
}
