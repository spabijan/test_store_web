import 'package:test_store_web/models/category.dart';

class CategoryViewModel {
  final CategoryModel _categoryModel;

  CategoryViewModel({required CategoryModel categoryModel})
      : _categoryModel = categoryModel;

  String get name => _categoryModel.name;
  String get image => _categoryModel.image;
  String get banner => _categoryModel.banner;
}
