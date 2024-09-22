import 'package:dartz/dartz.dart';
import 'package:test_2go_bank/domain/entities/promotion_entity.dart';

import '/core/error/failure.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> fetchProduct(int id);
  Future<Either<Failure, PromotionEntity>> fetchProductPromotion(int productId);
}
