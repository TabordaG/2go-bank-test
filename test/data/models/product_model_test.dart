import 'package:flutter_test/flutter_test.dart';
import 'package:test_2go_bank/data/models/product_model.dart';
import 'package:test_2go_bank/domain/entities/product_entity.dart';

void main() {
  const testProduct = ProductModel(
    id: 1,
    name: 'Test Product',
    price: 1000,
  );

  test('should return a valid Product Entity', () async {
    final result = testProduct.toEntity();

    expect(result, isA<ProductEntity>());
    expect(result.id, testProduct.id);
    expect(result.name, testProduct.name);
    expect(result.price, testProduct.price);
  });

  test('should return a valid Product Model', () async {
    final result = ProductModel.fromEntity(testProduct);
    expect(result, isA<ProductModel>());
    expect(result.id, testProduct.id);
    expect(result.name, testProduct.name);
    expect(result.price, testProduct.price);
  });
}
