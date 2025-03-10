import 'package:cleopatras_secrets/src/feature/rituals/repository/repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencyInjection() {
  locator.registerLazySingleton(() => Repository());
}
