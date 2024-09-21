import 'package:encrypt/encrypt.dart';

import '../../constant/app_constant.dart';

class Encryptor {
  late Key _key;
  late IV _iv;
  late Encrypter _encrypter;

  Encryptor() {
    _key = Key.fromBase64(AppConstant.secretKey);
    _iv = IV.fromBase64(AppConstant.secretIV);
    _encrypter = Encrypter(AES(_key));
  }

  Encrypted encrypt(String plainText) {
    return _encrypter.encrypt(plainText, iv: _iv);
  }

  String decrypt(Encrypted encrypted) {
    return _encrypter.decrypt(encrypted, iv: _iv);
  }
}
