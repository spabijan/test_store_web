import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_store_web/errors/http_error.dart';

final class HttpResponseUtils {
  HttpResponseUtils._();
  static void checkForHttpResponseErrors({
    required http.Response response,
  }) {
    switch (response.statusCode) {
      case 200 || 201 || 204:
        return; //status ok - nothing to return
      case 400 || 404:
        throw HttpError(message: json.decode(response.body)['msg']);
      case 500:
        throw HttpError(message: json.decode(response.body)['error']);
    }
  }
}
