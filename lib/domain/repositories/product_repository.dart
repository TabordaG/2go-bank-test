import 'package:dartz/dartz.dart';

import '/core/error/failure.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> fetchProduct(int id);
}
