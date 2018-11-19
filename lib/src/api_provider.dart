import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:mobile/src/models/cake_order_model.dart';

class ApiProvider {

  Client client = Client();
  final _baseUrl = "http://192.168.1.74:8080/open-api";

  Future<CakeOrdersModel> fetchCakeOrders() async {
    try {
      final response = await client.get("$_baseUrl/cake-orders");

      if (response.statusCode == 200) {
        return CakeOrdersModel.fromJson(json.decode(response.body));
      } else {
        return Future.value(CakeOrdersModel());
      }
    } catch(e) {
      print(e);
      return Future.value(CakeOrdersModel());
    }
  }

  Future<void> createCakeOrder(CakeOrderModel model) async {
    print(model.toJson());
    final response = await client.post(
        '$_baseUrl/cake-orders',
        headers: {'Content-type' : 'application/json'},
        body: jsonEncode(model.toJson())
    );

    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to create cake order');
    }
  }

}