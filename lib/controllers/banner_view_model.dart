import 'package:flutter/material.dart';
import 'package:test_store_web/models/banner.dart';

class BannerViewModel {
  final BannerModel _bannerModel;

  BannerViewModel({required BannerModel bannerModel})
      : _bannerModel = bannerModel;

  String get image => _bannerModel.image;
}
