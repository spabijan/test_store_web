import 'package:test_store_web/models/banner/banner.dart';

class BannerViewModel {
  final BannerModel _bannerModel;

  BannerViewModel({required BannerModel bannerModel})
      : _bannerModel = bannerModel;

  String get image => _bannerModel.image;
}
