import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tray_dryer_app/common/common.dart';

class DataRepository {
  Future<void> send({
    @required String name,
    @required int setTemperature,
    @required int processTimer,
    @required int readInterval,
  }) async {
    final storage = new FlutterSecureStorage();

    String token = await storage.read(key: 'token');
    final String url = "http://$BASE_URL:8023/process";
    Map<String, String> headers = {
      'x-access-token': token,
      'content-type': 'application/json'
    };

    Map<String, dynamic> body = {
      'name': name,
      'stemp': setTemperature,
      'ctime': processTimer,
      'rinte': readInterval
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );

    switch (response.statusCode) {
      case 401:
        {
          throw Exception('Invalid token. Please login again');
        }
        break;

      case 403:
        {
          throw Exception('Process ongoing!');
        }
        break;

      default:
        {}
        break;
    }

    return;
  }
}
