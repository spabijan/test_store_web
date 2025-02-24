import 'dart:collection';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:test_store_web/constants/global_variables.dart';
import 'package:test_store_web/models/banner.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:test_store_web/services/manage_http_responses.dart';

final class BannersScreenViewModel extends ChangeNotifier {
  bool isloading = false;
  bool isSending = false;
  String error = '';
  List<BannerModel> _banners = [];
  UnmodifiableListView<BannerModel> get bannerList =>
      UnmodifiableListView(_banners);

  Future<void> uploadBanner({required dynamic pickedImage}) async {
    try {
      isSending = true;
      notifyListeners();

      final cloudinary = CloudinaryPublic('dzjzk8do0', 'web-abb-learning');
      var imageResponseFuture = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: 'banner', folder: 'banner'));

      var newBanner = BannerModel(image: imageResponseFuture.secureUrl);

      var postCategoryResponse = await http.post(
          Uri.parse('${GlobalVariables.uri}/api/banner'),
          body: json.encode(newBanner.toJson()),
          headers: GlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(
          response: postCategoryResponse);
    } catch (e) {
      error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      isSending = false;
      notifyListeners();
      loadBanners();
    }
  }

  void loadBanners() async {
    try {
      isloading = true;
      notifyListeners();

      var response = await http.get(
          Uri.parse('${GlobalVariables.uri}/api/banner'),
          headers: GlobalVariables.headers);

      HttpResponseUtils.checkForHttpResponseErrors(response: response);

      List<dynamic> data = jsonDecode(response.body);
      _banners = [for (final datum in data) BannerModel.fromJson(datum)];
      notifyListeners();
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
