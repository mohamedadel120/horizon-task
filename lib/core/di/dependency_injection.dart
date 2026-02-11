import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task/core/helpers/api_constants.dart';
import 'package:task/core/networking/api_client.dart';
import 'package:task/core/networking/dio_factory.dart';
import 'package:task/core/networking/network_info.dart';
import 'package:task/core/services/auth_service.dart';
import 'package:task/features/auth/data/repositories/auth_repository.dart';
import 'package:task/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task/features/home/data/datasources/home_firestore_service.dart';
import 'package:task/features/home/data/repository/home_repository.dart';
import 'package:task/features/home/logic/home_cubit.dart';

final sl = GetIt.instance;
Future<void> setupGetIt() async {
  Dio dio = DioFactory.getDio();
  sl.registerLazySingleton<Dio>(() => dio);

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo());
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      networkInfo: sl<NetworkInfo>(),
      baseUrl: ApiConstants.baseUrl, // Use baseUrl from constants
    ),
  );

  /// Auth Services (Google, Apple, Email/Password)
  sl.registerLazySingleton<AuthService>(() => AuthService());
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(sl<AuthService>()),
  );
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl<AuthRepository>()));

  /// Home - Firestore categories & products
  sl.registerLazySingleton<HomeFirestoreService>(
    () => HomeFirestoreService(FirebaseFirestore.instance),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepository(sl<HomeFirestoreService>()),
  );
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<HomeRepository>()));
}
