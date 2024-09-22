import 'package:dartz/dartz.dart';

import '/core/error/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

abstract class FetchProductUseCase {
  Future<Either<Failure, ProductEntity>> call(int id);
}

class FetchProductUseCaseImpl implements FetchProductUseCase {
  final ProductRepository repository;

  FetchProductUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(int id) {
    return repository.fetchProduct(id);
  }
}
