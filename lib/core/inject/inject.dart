import 'package:get_it/get_it.dart';
import 'package:test_2go_bank/data/data_sources/remote_data_source.dart';
import 'package:test_2go_bank/domain/usecases/fetch_product_usecase.dart';
import 'package:test_2go_bank/presentation/viewmodel/checkout_viewmodel.dart';

import '../../data/repositories/product_repository_imp.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/calculate_purchase_total_usecase.dart';
import '../../domain/usecases/fetch_product_promotion_usecase.dart';

final sl = GetIt.I;

Future<void> initInject() async {
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl());

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImp(remoteDataSource: sl()));

  sl.registerLazySingleton<FetchProductUseCase>(
      () => FetchProductUseCaseImpl(sl()));
  sl.registerLazySingleton<FetchProductPromotionUseCase>(
      () => FetchProductPromotionUseCaseImpl(sl()));
  sl.registerLazySingleton<CalculatePurchaseTotalUsecase>(
      () => CalculatePurchaseTotalUsecaseImpl());

  sl.registerLazySingleton<CheckoutViewModel>(
      () => CheckoutViewModel(sl(), sl(), sl()));
}
