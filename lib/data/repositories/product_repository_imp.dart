import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/promotion_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/remote_data_source.dart';

class ProductRepositoryImp implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  // final ProductLocalDataSource localDataSource;
  // final NetworkInfo networkInfo;

  ProductRepositoryImp({
    required this.remoteDataSource,
    // required this.localDataSource,
    // required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProductEntity>> fetchProduct(int id) async {
    try {
      final product = await remoteDataSource.fetchProduct(id);
      // localDataSource.cacheProduct(product);
      return Right(product);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PromotionEntity>> fetchProductPromotion(
      int productId) async {
    try {
      final promotion = await remoteDataSource.fetchProductPromotion(productId);
      // localDataSource.cachePromotion(promotion);
      return Right(promotion);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
