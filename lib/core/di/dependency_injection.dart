import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task/core/helpers/api_constants.dart';
import 'package:task/core/networking/api_client.dart';
import 'package:task/core/networking/dio_factory.dart';
import 'package:task/core/networking/network_info.dart';
import 'package:task/core/services/firebase_messaging_service.dart';
// import 'package:task/core/services/chat_notification_service.dart';
// import 'package:task/core/services/firebase_chat_service.dart';
/*
import 'package:task/features/auth/forget_password/controllers/cubit/forget_password_cubit.dart';
import 'package:task/features/auth/forget_password/data/api_services/forget_password_api_services.dart';
import 'package:task/features/auth/forget_password/data/repos/forget_password_rep.dart';
import 'package:task/features/auth/login/data/api/login_api_services.dart';
import 'package:task/features/auth/login/data/repository/login_repo.dart';
import 'package:task/features/auth/login/controller/cubit/login_cubit.dart';
import 'package:task/features/auth/register/data/api/register_api_services.dart';
import 'package:task/features/auth/register/data/repository/register_repo.dart';
import 'package:task/features/auth/register/controller/cubit/register_cubit.dart';
import 'package:task/features/add_product/data/api/add_product_service.dart';
import 'package:task/features/add_product/data/repository/add_product_repository.dart';
import 'package:task/features/add_product/logic/cubit/create_advertisement_cubit.dart';
import 'package:task/features/home/data/api/categories_service.dart';
import 'package:task/features/home/data/api/cities_service.dart';
import 'package:task/features/home/data/api/areas_service.dart';
import 'package:task/features/home/data/repository/categories_repository.dart';
import 'package:task/features/home/data/repository/cities_repository.dart';
import 'package:task/features/home/data/repository/areas_repository.dart';
import 'package:task/features/home/controller/cubit/categories_cubit.dart';
import 'package:task/features/home/controller/cubit/cities_cubit.dart';
import 'package:task/features/home/controller/cubit/areas_cubit.dart';
import 'package:task/features/home/data/api/advertisements_service.dart';
import 'package:task/features/home/data/repository/advertisements_repository.dart';
import 'package:task/features/home/controller/cubit/advertisements_cubit.dart';
import 'package:task/features/favorites/data/api/my_ads_service.dart';
import 'package:task/features/favorites/data/repository/my_ads_repository.dart';
import 'package:task/features/favorites/logic/cubit/my_ads_cubit.dart';
import 'package:task/features/home/data/api/advertisement_details_service.dart';
import 'package:task/features/home/data/repository/advertisement_details_repository.dart';
import 'package:task/features/home/controller/cubit/advertisement_details_cubit.dart';
import 'package:task/features/incoming_contract/data/api/contracts_service.dart';
import 'package:task/features/incoming_contract/data/repository/contracts_repository.dart';
import 'package:task/features/incoming_contract/logic/cubit/contract_cubit.dart';
import 'package:task/features/outgoing_contract/data/api/outgoing_contracts_service.dart';
import 'package:task/features/outgoing_contract/data/repository/outgoing_contracts_repository.dart';
import 'package:task/features/outgoing_contract/logic/cubit/outgoing_contract_cubit.dart';
import 'package:task/features/create_contract/data/api/create_contract_service.dart';
import 'package:task/features/create_contract/data/repository/create_contract_repository.dart';
import 'package:task/features/create_contract/logic/cubit/create_contract_cubit.dart';
import 'package:task/features/search/controller/cubit/search_cubit.dart';
import 'package:task/features/profile/data/api/profile_api_service.dart';
import 'package:task/features/profile/data/repository/profile_repository.dart';
import 'package:task/features/profile/controller/cubit/profile_cubit.dart';
import 'package:task/core/localization/cubit/locale_cubit.dart';
import 'package:task/features/bottom_nav_bar/controllers/cubit/bottom_nav_cubit.dart';
import 'package:task/features/settings/data/api/privacy_security_api_service.dart';
import 'package:task/features/settings/data/repository/privacy_security_repository.dart';
import 'package:task/features/settings/controller/cubit/privacy_security_cubit.dart';
import 'package:task/features/settings/data/api/terms_and_conditions_service.dart';
import 'package:task/features/settings/data/repository/terms_and_conditions_repository.dart';
import 'package:task/features/settings/controller/cubit/terms_and_conditions_cubit.dart';
import 'package:task/features/auth/device_token/data/api/device_token_service.dart';
import 'package:task/features/auth/device_token/data/repository/device_token_repository.dart';
import 'package:task/features/auth/logout/data/api/logout_service.dart';
import 'package:task/features/auth/logout/data/repository/logout_repository.dart';
import 'package:task/features/auth/logout/logic/cubit/logout_cubit.dart';
import 'package:task/features/chat/data/api/upload_image_service.dart';
import 'package:task/features/chat/data/repository/chat_repository.dart';
import 'package:task/features/chat/logic/cubit/chat_cubit.dart';
import 'package:task/features/statistics/data/api/analysis_service.dart';
import 'package:task/features/statistics/data/repository/analysis_repository.dart';
import 'package:task/features/statistics/logic/cubit/statistics_cubit.dart';
import 'package:task/features/notifications/data/api/notifications_service.dart';
import 'package:task/features/notifications/data/repository/notifications_repository.dart';
import 'package:task/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:task/features/user_profile/data/api/user_profile_service.dart';
import 'package:task/features/user_profile/data/repository/user_profile_repository.dart';
import 'package:task/features/user_profile/logic/cubit/user_profile_cubit.dart';
import 'package:task/features/contact_us/data/api/contact_us_service.dart';
import 'package:task/features/contact_us/data/repository/contact_us_repository.dart';
import 'package:task/features/contact_us/logic/cubit/contact_us_cubit.dart';
import 'package:task/features/faq/data/api/faq_service.dart';
import 'package:task/features/faq/data/repository/faq_repository.dart';
import 'package:task/features/faq/logic/cubit/faq_cubit.dart';
import 'package:task/features/missing_requests/data/api/missing_requests_service.dart';
import 'package:task/features/missing_requests/data/repository/missing_requests_repository.dart';
import 'package:task/features/missing_requests/logic/cubit/missing_requests_cubit.dart';
import 'package:task/features/missing_requests/logic/cubit/add_missing_request_cubit.dart';
import 'package:task/features/missing_requests/data/api/comments_service.dart';
import 'package:task/features/missing_requests/data/repository/comments_repository.dart';
import 'package:task/features/missing_requests/logic/cubit/comments_cubit.dart';
import 'package:task/features/favorites/data/api/favorites_service.dart';
import 'package:task/features/favorites/data/repository/favorites_repository.dart';
import 'package:task/features/favorites/logic/cubit/favorites_cubit.dart';
*/

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

  /*
  ///device token
  sl.registerLazySingleton<DeviceTokenService>(() => DeviceTokenService(sl()));
  sl.registerLazySingleton<DeviceTokenRepository>(
    () => DeviceTokenRepository(sl(), sl<FirebaseMessagingService>()),
  );

  ///authentication
  sl.registerLazySingleton<LoginService>(() => LoginService(sl()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepository(sl()));
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(sl(), sl<DeviceTokenRepository>()),
  );

  ///logout
  sl.registerLazySingleton<LogoutService>(() => LogoutService(sl()));
  sl.registerLazySingleton<LogoutRepository>(() => LogoutRepository(sl()));
  sl.registerFactory<LogoutCubit>(() => LogoutCubit(sl()));

  ///register
  sl.registerLazySingleton<RegisterApiServices>(() => RegisterApiServices(dio));
  sl.registerLazySingleton<RegisterRepo>(() => RegisterRepo(sl()));
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl()));

  ///forget password
  sl.registerLazySingleton<ForgetPasswordApiServices>(
    () => ForgetPasswordApiServices(dio),
  );
  sl.registerLazySingleton<ForgetPasswordRepo>(() => ForgetPasswordRepo(sl()));
  sl.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(forgetPasswordRepo: sl()),
  );

  ///categories
  sl.registerLazySingleton<CategoriesService>(() => CategoriesService(sl()));
  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepository(sl()),
  );
  sl.registerFactory<CategoriesCubit>(() => CategoriesCubit(sl()));

  ///cities
  sl.registerLazySingleton<CitiesService>(() => CitiesService(sl()));
  sl.registerLazySingleton<CitiesRepository>(() => CitiesRepository(sl()));
  sl.registerFactory<CitiesCubit>(() => CitiesCubit(sl()));

  ///areas
  sl.registerLazySingleton<AreasService>(() => AreasService(sl()));
  sl.registerLazySingleton<AreasRepository>(() => AreasRepository(sl()));
  sl.registerFactory<AreasCubit>(() => AreasCubit(sl()));

  ///advertisements
  sl.registerLazySingleton<AdvertisementsService>(
    () => AdvertisementsService(sl()),
  );
  sl.registerLazySingleton<AdvertisementsRepository>(
    () => AdvertisementsRepository(sl()),
  );
  sl.registerFactory<AdvertisementsCubit>(
    () => AdvertisementsCubit(
      sl(),
      favoritesRepository: sl<FavoritesRepository>(),
    ),
  );
  sl.registerFactory<SearchCubit>(() => SearchCubit(sl()));

  ///add product
  sl.registerLazySingleton<AddProductService>(() => AddProductService(sl()));
  sl.registerLazySingleton<AddProductRepository>(
    () => AddProductRepository(sl()),
  );
  sl.registerFactory<CreateAdvertisementCubit>(
    () => CreateAdvertisementCubit(sl()),
  );

  ///advertisement details
  sl.registerLazySingleton<AdvertisementDetailsService>(
    () => AdvertisementDetailsService(sl()),
  );
  sl.registerLazySingleton<AdvertisementDetailsRepository>(
    () => AdvertisementDetailsRepository(sl()),
  );
  sl.registerFactory<AdvertisementDetailsCubit>(
    () => AdvertisementDetailsCubit(sl()),
  );

  ///my ads
  sl.registerLazySingleton<MyAdsService>(() => MyAdsService(sl()));
  sl.registerLazySingleton<MyAdsRepository>(() => MyAdsRepository(sl()));
  sl.registerFactory<MyAdsCubit>(() => MyAdsCubit(sl()));

  ///contracts
  sl.registerLazySingleton<ContractsService>(() => ContractsService(sl()));
  sl.registerLazySingleton<ContractsRepository>(
    () => ContractsRepository(sl()),
  );
  sl.registerFactory<ContractCubit>(() => ContractCubit(sl()));
  sl.registerLazySingleton<OutgoingContractsService>(
    () => OutgoingContractsService(sl()),
  );
  sl.registerLazySingleton<OutgoingContractsRepository>(
    () => OutgoingContractsRepository(sl()),
  );
  sl.registerFactory<OutgoingContractCubit>(() => OutgoingContractCubit(sl()));

  ///create contract
  sl.registerLazySingleton<CreateContractService>(
    () => CreateContractService(sl()),
  );
  sl.registerLazySingleton<CreateContractRepository>(
    () => CreateContractRepository(sl()),
  );
  sl.registerFactory<CreateContractCubit>(() => CreateContractCubit(sl()));

  ///profile
  sl.registerLazySingleton<ProfileApiService>(() => ProfileApiService(sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepository(sl()));
  sl.registerLazySingleton<ProfileCubit>(
    () => ProfileCubit(sl(), sl<LocaleCubit>()),
  );

  ///bottom nav bar
  sl.registerLazySingleton<BottomNavCubit>(() => BottomNavCubit());

  ///privacy security
  sl.registerLazySingleton<PrivacySecurityApiService>(
    () => PrivacySecurityApiService(sl()),
  );
  sl.registerLazySingleton<PrivacySecurityRepository>(
    () => PrivacySecurityRepository(sl()),
  );
  sl.registerFactory<PrivacySecurityCubit>(() => PrivacySecurityCubit(sl()));

  ///terms and conditions
  sl.registerLazySingleton<TermsAndConditionsService>(
    () => TermsAndConditionsService(sl<ApiClient>()),
  );
  sl.registerLazySingleton<TermsAndConditionsRepository>(
    () => TermsAndConditionsRepository(sl<TermsAndConditionsService>()),
  );
  sl.registerFactory<TermsAndConditionsCubit>(
    () => TermsAndConditionsCubit(sl<TermsAndConditionsRepository>()),
  );

  ///firebase chat
  sl.registerLazySingleton<FirebaseChatService>(() => FirebaseChatService());

  ///chat notification
  sl.registerLazySingleton<ChatNotificationService>(
    () => ChatNotificationService(),
  );

  ///chat
  sl.registerLazySingleton<UploadImageService>(() => UploadImageService(sl()));
  sl.registerLazySingleton<ChatRepository>(() => ChatRepository(sl(), sl()));
  sl.registerFactory<ChatCubit>(() => ChatCubit(sl(), sl()));

  ///statistics
  sl.registerLazySingleton<AnalysisService>(() => AnalysisService(sl()));
  sl.registerLazySingleton<AnalysisRepository>(() => AnalysisRepository(sl()));
  sl.registerFactory<StatisticsCubit>(() => StatisticsCubit(sl()));

  ///notifications
  sl.registerLazySingleton<NotificationsService>(
    () => NotificationsService(sl()),
  );
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepository(sl()),
  );
  sl.registerLazySingleton<NotificationsCubit>(() => NotificationsCubit(sl()));

  ///user profile
  sl.registerLazySingleton<UserProfileService>(() => UserProfileService(sl()));
  sl.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepository(sl()),
  );
  sl.registerFactoryParam<UserProfileCubit, int, void>(
    (userId, _) => UserProfileCubit(repository: sl(), userId: userId),
  );

  ///contact us
  sl.registerLazySingleton<ContactUsService>(() => ContactUsService(sl()));
  sl.registerLazySingleton<ContactUsRepository>(
    () => ContactUsRepository(sl()),
  );
  sl.registerFactory<ContactUsCubit>(() => ContactUsCubit(repository: sl()));

  ///faq
  sl.registerLazySingleton<FAQService>(() => FAQService(sl()));
  sl.registerLazySingleton<FAQRepository>(() => FAQRepository(sl()));
  sl.registerFactory<FAQCubit>(() => FAQCubit(repository: sl()));

  ///missing requests
  sl.registerLazySingleton<MissingRequestsService>(
    () => MissingRequestsService(sl()),
  );
  sl.registerLazySingleton<MissingRequestsRepository>(
    () => MissingRequestsRepository(sl()),
  );
  sl.registerFactory<MissingRequestsCubit>(() => MissingRequestsCubit(sl()));
  sl.registerFactory<AddMissingRequestCubit>(
    () => AddMissingRequestCubit(sl()),
  );

  ///comments
  sl.registerLazySingleton<CommentsService>(() => CommentsService(sl()));
  sl.registerLazySingleton<CommentsRepository>(() => CommentsRepository(sl()));
  sl.registerFactory<CommentsCubit>(() => CommentsCubit(sl()));

  ///favorites
  sl.registerLazySingleton<FavoritesService>(() => FavoritesService(sl()));
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepository(sl()),
  );
  sl.registerFactory<FavoritesCubit>(() => FavoritesCubit(sl()));
  */
}
