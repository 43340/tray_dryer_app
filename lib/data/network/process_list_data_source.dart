import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tray_dryer_app/common/get_token.dart';
import 'package:tray_dryer_app/data/model/process/model_process.dart';

class ProcessListDataSource {
  final http.Client client;

  final String _baseUrl = "http://192.168.254.102:8023/process/";

  ProcessListDataSource(this.client);

  Future<ProcessList> fetchProcess() async {
    String token = await getToken();

    Map<String, String> headers = {
      'x-access-token': token,
      'content-type': 'application/json'
    };

    final url = Uri.encodeFull(_baseUrl);
    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return ProcessList.fromJson(response.body);
    } else {
      throw ProcessListError('Failed to fetch list of process');
    }
  }
}
