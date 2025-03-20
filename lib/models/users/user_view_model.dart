import 'package:test_store_web/models/users/user.dart';

class UserViewModel {

  UserViewModel({required UserModel model}) : _model = model;
  final UserModel _model;

  String get fullName => _model.fullName;
  String get email => _model.email;
  String get state => _model.state;
  String get city => _model.city;
  String get locality => _model.locality;
  String get address => '$state $city $locality';
}
