import 'package:test_store_web/models/banner/banner.dart';

class BannerViewModel {

  BannerViewModel({required BannerModel bannerModel})
      : _bannerModel = bannerModel;
  final BannerModel _bannerModel;

  String get image => _bannerModel.image;
}
