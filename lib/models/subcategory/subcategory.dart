import 'package:freezed_annotation/freezed_annotation.dart';

part 'subcategory.freezed.dart';
part 'subcategory.g.dart';

@freezed
class SubcategoryModel with _$SubcategoryModel {
  const factory SubcategoryModel(
          {@JsonKey(name: '_id') @Default('') String id,
          required String categoryId,
          required String categoryName,
          @JsonKey(name: 'image') required String categoryImage,
          @JsonKey(name: 'subCategoryName') required String subcategoryName}) =
      _SubcategoryModel;

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryModelFromJson(json);
}
