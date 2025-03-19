import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
      {required String fullName,
      required String email,
      required String state,
      required String city,
      required String locality,
      @JsonKey(name: '_id') @Default('') String id}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
