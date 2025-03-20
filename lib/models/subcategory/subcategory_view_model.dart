import 'package:test_store_web/models/subcategory/subcategory.dart';

class SubcategoryViewModel {

  SubcategoryViewModel({required SubcategoryModel subcategoryModel})
      : _subcategoryModel = subcategoryModel;
  final SubcategoryModel _subcategoryModel;

  String get categoryId => _subcategoryModel.categoryId;
  String get categoryName => _subcategoryModel.categoryName;
  String get categoryImage => _subcategoryModel.categoryImage;
  String get subcategoryName => _subcategoryModel.subcategoryName;
}
