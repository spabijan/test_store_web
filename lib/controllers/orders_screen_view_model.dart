import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_store_web/constants/global_variables.dart';
import 'package:test_store_web/models/order/order.dart';
import 'package:test_store_web/models/order/order_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:test_store_web/services/manage_http_responses.dart';

class OrdersScreenViewModel extends ChangeNotifier {
  bool isLoading = false;
  String error = '';

  List<OrderViewModel> _orders = [];
  UnmodifiableListView<OrderViewModel> get orderList =>
      UnmodifiableListView(_orders);

  Future<void> loadOrders() async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http.get(
          Uri.parse('${GlobalVariables.uri}/api/orders'),
          headers: GlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
      List<dynamic> data = jsonDecode(response.body);
      _orders = [
        for (final datum in data)
          OrderViewModel(orderModel: OrderModel.fromJson(datum))
      ];
    } catch (e) {
      error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
