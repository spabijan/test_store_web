import 'package:test_store_web/models/category/category.dart';

class CategoryViewModel {

  CategoryViewModel({required CategoryModel categoryModel})
      : _categoryModel = categoryModel;
  final CategoryModel _categoryModel;

  String get name => _categoryModel.name;
  String get image => _categoryModel.image;
  String get banner => _categoryModel.banner;
  String get id => _categoryModel.id;
}
