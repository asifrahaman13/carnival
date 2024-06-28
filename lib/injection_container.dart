import 'package:carnival/infastructure/repositories/auth_repository.dart';
import 'package:carnival/infastructure/repositories/recommendation_repository.dart';
import 'package:carnival/internal/interfaces/auth_interface.dart';
import 'package:carnival/internal/interfaces/recommendation_interface.dart';
import 'package:carnival/internal/use_cases/auth_service.dart';
import 'package:carnival/internal/use_cases/recommendation_service.dart';
import 'package:get_it/get_it.dart';


final sl = GetIt.instance;

void init() {
  // Features - Auth
  sl.registerFactory(() => AuthService(sl()));
  sl.registerFactory(() => RecommendationService(sl()));

  // Repository
  sl.registerLazySingleton<AuthInterface>(() => AuthRepository());
  sl.registerLazySingleton<RecommendationInterface>(() => RecommendationRepository());

  // Core
  // External
}
