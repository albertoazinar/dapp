import 'package:despensa/services/auth_service.dart';
import 'package:despensa/services/prateleira_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setUpGetIt() {
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => PrateleiraService());
}
