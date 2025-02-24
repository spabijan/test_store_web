import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:test_store_web/constants/global_variables.dart';
import 'package:test_store_web/services/manage_http_responses.dart';
import '../models/category.dart' as cms_app_category;
import "package:http/http.dart" as http;

class CategoryController {
  uploadCategory(
      {required dynamic pickedImage,
      required dynamic pickedBanner,
      required String name,
      required context}) async {
    try {
      final cloudinary = CloudinaryPublic('dzjzk8do0', 'web-abb-learning');
      var imageResponseFuture = cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: 'pickedImage', folder: 'categoryImages'));

      var bannerResponseFuture = cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedBanner,
              identifier: 'categoryBanners', folder: 'categoryBanners'));

      var imageUrl = await imageResponseFuture;
      var bannerUrl = await bannerResponseFuture;

      var newCategory = cms_app_category.Category(
          name: name, image: imageUrl.secureUrl, banner: bannerUrl.secureUrl);
      var postCategoryResponse = await http.post(
          Uri.parse('${GlobalVariables.uri}/api/categories'),
          body: json.encode(newCategory.toJson()),
          headers: GlobalVariables.headers);
      HttpResponseUtils.manageHttpResponse(
          response: postCategoryResponse,
          context: context,
          onSuccess: () {
            HttpResponseUtils.showSnackbar(context, 'Uploaded Category');
          });
    } catch (e) {
      print('Error uploading to cloudinary: $e');
    }
  }
}
