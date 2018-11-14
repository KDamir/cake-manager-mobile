import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:mobile/src/api_provider.dart';

void main() {
  test("fetchCakeOrders should return json array", () async {
    //setup the test
    final apiProvider = ApiProvider();
    apiProvider.client = MockClient((request) async {
      final mapJson = [
        {
          "id": 1151,
          "name": "asd",
          "decor": "asd",
          "createdDate": "2018-11-03T11:00:00Z",
          "onDate": "2018-11-04T12:00:00Z",
          "price": 100.00,
          "description": "qwe",
          "clientName": "asd",
          "clientContact": "asd"
        }
      ];

      return Response(json.encode(mapJson), 200);
    });
    final res = await apiProvider.fetchCakeOrders();
    expect(res.results.length, 1);
  });
}