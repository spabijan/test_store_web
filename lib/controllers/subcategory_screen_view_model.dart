import 'dart:collection';
import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:test_store_web/constants/global_variables.dart';
import 'package:test_store_web/models/category/category.dart';
import 'package:test_store_web/models/subcategory/subcategory.dart';
import "package:http/http.dart" as http;
import 'package:test_store_web/models/subcategory/subcategory_view_model.dart';
import 'package:test_store_web/services/manage_http_responses.dart';

final class SubcategoryScreenViewModel extends ChangeNotifier {
  CategoryModel? _selectedCategory;
  String error = '';
  List<SubcategoryViewModel> _subcategories = List.empty(growable: true);
  UnmodifiableListView<SubcategoryViewModel> get subcategories =>
      UnmodifiableListView(_subcategories);

  CategoryModel? get selectedCategory => _selectedCategory;
  set selectedCategory(CategoryModel? newValue) {
    _selectedCategory = newValue;
    notifyListeners();
  }

  dynamic _image;
  get image => _image;
  set image(newImage) {
    _image = newImage;
    notifyListeners();
  }

  late String _subcategoryName;
  String get subcategoryName => _subcategoryName;
  set subcategoryName(newValue) {
    _subcategoryName = newValue;
  }

  bool isLoading = false;
  bool isSending = false;

  String? validateNewCategoryName(value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return 'Please enter category name';
    }
  }

  void reset() {
    _subcategoryName = '';
    _image = null;
    error = '';
    notifyListeners();
  }

  Future<void> uploadSubcategory() async {
    try {
      isSending = true;
      notifyListeners();

      final cloudinary = CloudinaryPublic('dzjzk8do0', 'web-abb-learning');
      var imageResponseFuture = cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(image,
              identifier: 'pickedImage', folder: 'subcategoryImages'));
      var imageUrl = await imageResponseFuture;

      var newSubcategory = SubcategoryModel(
          categoryId: _selectedCategory!.id,
          categoryName: subcategoryName,
          categoryImage: imageUrl.secureUrl,
          subcategoryName: subcategoryName);

      var postSubcategoryResponse = await http.post(
          Uri.parse('${GlobalVariables.uri}/api/subcategories'),
          body: json.encode(newSubcategory.toJson()),
          headers: GlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(
          response: postSubcategoryResponse);
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isSending = false;
      notifyListeners();
    }
  }

  Future<void> loadsubCategories() async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http.get(
          Uri.parse('${GlobalVariables.uri}/api/subcategories'),
          headers: GlobalVariables.headers);

      HttpResponseUtils.checkForHttpResponseErrors(response: response);

      List<dynamic> data = jsonDecode(response.body);
      _subcategories = [
        for (final datum in data)
          SubcategoryViewModel(
              subcategoryModel: SubcategoryModel.fromJson(datum))
      ];
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
