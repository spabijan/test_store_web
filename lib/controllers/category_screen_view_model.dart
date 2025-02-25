import 'dart:collection';
import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:test_store_web/constants/global_variables.dart';
import 'package:test_store_web/models/category/category.dart';
import 'package:test_store_web/services/manage_http_responses.dart';

import "package:http/http.dart" as http;

final class CategoryScreenViewModel extends ChangeNotifier {
  bool isSending = false;
  bool isLoading = false;
  String error = '';
  List<CategoryModel> _categories = List.empty(growable: true);
  UnmodifiableListView<CategoryModel> get categoriesList =>
      UnmodifiableListView(_categories);

  Future<void> uploadCategory(
      {required dynamic pickedImage,
      required dynamic pickedBanner,
      required String name,
      required context}) async {
    try {
      isSending = true;
      notifyListeners();

      final cloudinary = CloudinaryPublic('dzjzk8do0', 'web-abb-learning');
      var imageResponseFuture = cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: 'pickedImage', folder: 'categoryImages'));

      var bannerResponseFuture = cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedBanner,
              identifier: 'categoryBanners', folder: 'categoryBanners'));

      var imageUrl = await imageResponseFuture;
      var bannerUrl = await bannerResponseFuture;

      var newCategory = CategoryModel(
          name: name, image: imageUrl.secureUrl, banner: bannerUrl.secureUrl);
      var postCategoryResponse = await http.post(
          Uri.parse('${GlobalVariables.uri}/api/categories'),
          body: json.encode(newCategory.toJson()),
          headers: GlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(
          response: postCategoryResponse);
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isSending = false;
      notifyListeners();
    }
  }

  Future<void> loadCategories() async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http.get(
          Uri.parse('${GlobalVariables.uri}/api/categories'),
          headers: GlobalVariables.headers);

      HttpResponseUtils.checkForHttpResponseErrors(response: response);

      List<dynamic> data = jsonDecode(response.body);
      _categories = [for (final datum in data) CategoryModel.fromJson(datum)];
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
