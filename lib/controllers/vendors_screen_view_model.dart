import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:test_store_web/constants/global_variables.dart';

import 'package:http/http.dart' as http;
import 'package:test_store_web/models/vendor/vendor.dart';
import 'package:test_store_web/models/vendor/vendor_view_model.dart';
import 'package:test_store_web/services/manage_http_responses.dart';

class VendorsScreenViewModel extends ChangeNotifier {
  bool isloading = false;
  String error = '';

  List<VendorViewModel> _vendors = [];
  UnmodifiableListView<VendorViewModel> get vendorsList =>
      UnmodifiableListView(_vendors);

  Future<void> loadVendors() async {
    try {
      isloading = true;
      notifyListeners();
      var response = await http.get(
          Uri.parse('${GlobalVariables.uri}/api/vendors'),
          headers: GlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
      List<dynamic> data = jsonDecode(response.body);
      _vendors = [
        for (final datum in data)
          VendorViewModel(vendorModel: VendorModel.fromJson(datum))
      ];
    } catch (e) {
      error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
}
