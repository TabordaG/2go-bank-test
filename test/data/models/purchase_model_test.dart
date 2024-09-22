import 'package:flutter_test/flutter_test.dart';
import 'package:test_2go_bank/data/models/product_model.dart';
import 'package:test_2go_bank/data/models/purchase_model.dart';
import 'package:test_2go_bank/domain/entities/product_entity.dart';
import 'package:test_2go_bank/domain/entities/purchase_entity.dart';

void main() {
  final testPurchase = PurchaseModel(
    id: 1,
    date: DateTime.now(),
    total: 1000,
    items: const [
      ProductModel(
        id: 1,
        name: 'Test Product',
        price: 1000,
      ),
    ],
  );

  test('should return a valid Purchase Entity', () async {
    final result = testPurchase.toEntity();

    expect(result, isA<PurchaseEntity>());
    expect(result.id, testPurchase.id);
    expect(result.date, testPurchase.date);
    expect(result.total, testPurchase.total);
    expect(result.items.first, isA<ProductEntity>());
  });
}
