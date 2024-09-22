import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/product_entity.dart';
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
      final remoteProduct = await remoteDataSource.fetchProduct(id);
      // localDataSource.cacheProduct(remoteProduct);
      return Right(remoteProduct);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
