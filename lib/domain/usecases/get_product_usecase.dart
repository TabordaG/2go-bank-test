import 'package:dartz/dartz.dart';

import '/core/error/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

abstract class GetProductUseCase {
  Future<Either<Failure, ProductEntity>> call(int id);
}

class GetProductUseCaseImpl implements GetProductUseCase {
  final ProductRepository repository;

  GetProductUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(int id) {
    return repository.getProduct(id);
  }
}
