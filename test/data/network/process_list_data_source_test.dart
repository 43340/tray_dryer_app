import 'dart:io';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:tray_dryer_app/data/model/process/model_process.dart';
import 'package:tray_dryer_app/data/network/process_list_data_source.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  String fixture(String name) =>
      File('test/data/fixtures/$name.json').readAsStringSync();

  MockClient mockClient;
  ProcessListDataSource processListDataSource;

  setUp(() {
    mockClient = MockClient();
    processListDataSource = ProcessListDataSource(mockClient);
  });

  group('fetch data', () {
    test('return list of process', () async {
      when(
        mockClient.get(
          argThat(
            startsWith('http://192.168.254.102:8023/process'),
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response(fixture('result'), 200,
            headers: {'content-type': 'application/json'}),
      );

      ProcessList result = await processListDataSource.fetchProcess();

      expect(result, TypeMatcher<ProcessList>());
      expect(result.name, startsWith('20190315184510'));
    });
  });
}
