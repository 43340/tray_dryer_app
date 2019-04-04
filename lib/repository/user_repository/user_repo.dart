import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:tray_dryer_app/models/login_model.dart';

class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    final String url = "http://192.168.254.102:8023/login";
    String token;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response =
        await http.post(url, headers: {'authorization': basicAuth});

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(response.statusCode);

      token = LoginModel.fromJson(responseJson).token;
    } else {
      //throw Exception('Login Failed. Please check username and password');
      throw Error();
    }

    return token;
  }

  Future<void> deleteToken() async {
    /// delete token from keystore
    final storage = new FlutterSecureStorage();

    await storage.delete(key: 'token');
    return;
  }

  Future<void> persistToken(String token) async {
    /// write token to keystore
    final storage = new FlutterSecureStorage();

    await storage.write(key: 'token', value: token);
    return;
  }

  Future<bool> hasToken() async {
    /// read token from keystore
    final storage = new FlutterSecureStorage();

    String token = await storage.read(key: 'token');

    if (token != null) {
      return true;
    } else {
      return false;
    }
  }
}
