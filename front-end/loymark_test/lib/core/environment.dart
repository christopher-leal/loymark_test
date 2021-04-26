import 'dart:io';

class Environment {
  Environment();
  static String apiUrl = Platform.isAndroid ? 'http://192.168.100.5:3000' : 'http://localhost:3000';
}
