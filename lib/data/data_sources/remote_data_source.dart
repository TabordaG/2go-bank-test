import 'package:collection/collection.dart';
import 'package:test_2go_bank/core/error/failure.dart';
import 'package:test_2go_bank/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<ProductModel> getProduct(int id) {
    final product =
        testProducts.firstWhereOrNull((element) => element.id == id);

    if (product != null) {
      return Future.value(product);
    } else {
      throw const DatabaseFailure('Product not found');
    }
  }
}

List<ProductModel> testProducts = [
  const ProductModel(
    id: 1,
    name: 'A',
    price: 0.5,
  ),
  const ProductModel(
    id: 2,
    name: 'B',
    price: 0.75,
  ),
  const ProductModel(
    id: 3,
    name: 'C',
    price: 0.25,
  ),
  const ProductModel(
    id: 4,
    name: 'D',
    price: 1.5,
  ),
  const ProductModel(
    id: 5,
    name: 'E',
    price: 2.0,
  ),
];
