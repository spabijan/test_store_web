import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor.freezed.dart';
part 'vendor.g.dart';

@freezed
class VendorModel with _$VendorModel {
  const factory VendorModel(
      {required String fullName,
      required String email,
      required String state,
      required String city,
      required String locality,
      required String role,
      @JsonKey(name: '_id') @Default('') String id}) = _VendorModel;

  factory VendorModel.fromJson(Map<String, dynamic> json) =>
      _$VendorModelFromJson(json);
}
