import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tray_dryer_app/common/common.dart';

class NewUserRepository {
  Future<void> send({
    @required String username,
    @required String password,
  }) async {
    final storage = new FlutterSecureStorage();

    String token = await storage.read(key: 'token');
    final String url = "http://$BASE_URL:8023/user";
    Map<String, String> headers = {
      'x-access-token': token,
      'content-type': 'application/json'
    };

    Map<String, dynamic> body = {
      'name': username,
      'password': password,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );

    switch (response.statusCode) {
      case 401:
        {
          throw "Invalid token.";
        }
        break;

      case 409:
        {
          throw "User exist";
        }
        break;

      default:
        {}
        break;
    }

    return;
  }
}
