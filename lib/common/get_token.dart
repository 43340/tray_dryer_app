import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> getToken() async {
  final storage = new FlutterSecureStorage();

  String token = await storage.read(key: 'token');

  return token;
}
