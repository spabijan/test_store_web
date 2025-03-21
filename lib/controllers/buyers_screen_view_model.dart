import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:test_store_web/constants/global_variables.dart';
import 'package:test_store_web/models/users/user.dart';
import 'package:test_store_web/models/users/user_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:test_store_web/services/manage_http_responses.dart';

class BuyersScreenViewModel extends ChangeNotifier {
  bool isloading = false;
  String error = '';

  List<UserViewModel> _users = [];
  UnmodifiableListView<UserViewModel> get userList =>
      UnmodifiableListView(_users);

  Future<void> loadUsers() async {
    try {
      isloading = true;
      notifyListeners();
      var response = await http.get(
          Uri.parse('${GlobalVariables.uri}/api/users'),
          headers: GlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
      List<dynamic> data = jsonDecode(response.body);
      _users = [
        for (final datum in data)
          UserViewModel(model: UserModel.fromJson(datum))
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
