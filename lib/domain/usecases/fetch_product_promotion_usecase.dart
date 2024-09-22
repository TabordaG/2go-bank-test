import 'package:dartz/dartz.dart';
import 'package:test_2go_bank/domain/entities/promotion_entity.dart';

import '/core/error/failure.dart';
import '../repositories/product_repository.dart';

abstract class FetchProductPromotionUseCase {
  Future<Either<Failure, PromotionEntity>> call(int productId);
}

class FetchProductPromotionUseCaseImpl implements FetchProductPromotionUseCase {
  final ProductRepository repository;

  FetchProductPromotionUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, PromotionEntity>> call(int productId) {
    return repository.fetchProductPromotion(productId);
  }
}
