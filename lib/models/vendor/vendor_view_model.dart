import 'package:test_store_web/models/vendor/vendor.dart';

class VendorViewModel {
  final VendorModel _vendorModel;

  VendorViewModel({required VendorModel vendorModel})
      : _vendorModel = vendorModel;

  String get fullName => _vendorModel.fullName;
  String get email => _vendorModel.email;
  String get state => _vendorModel.state;
  String get city => _vendorModel.city;
  String get locality => _vendorModel.locality;
  String get address => '$state $city $locality';
}
