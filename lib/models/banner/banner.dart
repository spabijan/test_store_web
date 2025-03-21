import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner.freezed.dart';
part 'banner.g.dart';

@freezed
class BannerModel with _$BannerModel {
  const factory BannerModel({
    required final String image, @JsonKey(name: '_id') @Default('') String id,
  }) = _Banner;

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}
