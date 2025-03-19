import 'package:test_store_web/models/users/user.dart';

class UserViewModel {
  final UserModel _model;

  UserViewModel({required UserModel model}) : _model = model;

  String get fullName => _model.fullName;
  String get email => _model.email;
  String get state => _model.state;
  String get city => _model.city;
  String get locality => _model.locality;
  String get address => '$state $city $locality';
}
