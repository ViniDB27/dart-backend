import 'dart:io';

class DotEnvService {
  final Map<String, String> _map = {};

  DotEnvService._() {
    _init();
  }

  static DotEnvService instance = DotEnvService._();

  void _init() {
    final file = File('.env');
    final envText = file.readAsStringSync();
    for (final line in envText.split('\n')) {
      final keyValue = line.split('=');
      if (keyValue.length == 2) {
        _map[keyValue[0]] = keyValue[1];
      }
    }
  }


  String? operator [](String key) => _map[key];
}
