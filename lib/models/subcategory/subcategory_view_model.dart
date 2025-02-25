import 'package:test_store_web/models/subcategory/subcategory.dart';

class SubcategoryViewModel {
  final SubcategoryModel _subcategoryModel;

  get categoryId => _subcategoryModel.categoryId;
  get categoryName => _subcategoryModel.categoryName;
  get categoryImage => _subcategoryModel.categoryImage;
  get subcategoryName => _subcategoryModel.subcategoryName;

  SubcategoryViewModel({required SubcategoryModel subcategoryModel})
      : _subcategoryModel = subcategoryModel;
}
