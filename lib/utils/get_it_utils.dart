import 'package:get_it/get_it.dart';
import 'package:test_store_web/controllers/category_controller.dart';

final class GetItUtils {
  GetItUtils._();
  static void getitSetup() {
    GetIt getIt = GetIt.instance;
    getIt.registerLazySingleton<CategoryController>(CategoryController.new);
  }
}
