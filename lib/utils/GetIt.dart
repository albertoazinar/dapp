import 'package:despensa/services/ListaComprasController.dart';
import 'package:despensa/services/auth_service.dart';
import 'package:despensa/services/familia_service.dart';
import 'package:despensa/services/prateleira_service.dart';
import 'package:despensa/services/produto_service.dart';
import 'package:despensa/utils/app_colors.dart';
import 'package:despensa/utils/sharedPreferences.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setUpGetIt() {
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => PrateleiraService());
  getIt.registerLazySingleton(() => FamiliaService());
  getIt.registerLazySingleton(() => UserState());
  getIt.registerLazySingleton(() => ProdutosServices.empty());
  getIt.registerLazySingleton(() => ListaComprasController());
  getIt.registerLazySingleton(() => ThemeChanger());
}
