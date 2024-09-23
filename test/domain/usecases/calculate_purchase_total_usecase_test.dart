import 'package:flutter_test/flutter_test.dart';
import 'package:test_2go_bank/domain/entities/product_entity.dart';
import 'package:test_2go_bank/domain/usecases/calculate_purchase_total_usecase.dart';

import '../../helpers/test_helper.dart';

void main() {
  late CalculatePurchaseTotalUsecaseImpl sut;

  setUp(() {
    sut = CalculatePurchaseTotalUsecaseImpl();
  });

  test('Calculate products with discount promotion', () {
    final result = sut.call(discountedProducts);
    expect(result, 1.75);

    List<ProductEntity> newList = [
      discountedProducts[0],
      discountedProducts[1].copyWith(amount: 3)
    ];
    final result2 = sut.call(newList);
    expect(result2, 2.5);
  });

  test('Calculate products with buy N free Y promotion', () {
    final result = sut.call(buyNgetYProducts);
    expect(result, 1.25);

    List<ProductEntity> newList = [
      buyNgetYProducts[0],
      buyNgetYProducts[1].copyWith(amount: 4)
    ];
    final result2 = sut.call(newList);
    expect(result2, 1.25);

    newList = [buyNgetYProducts[0], buyNgetYProducts[1].copyWith(amount: 5)];
    final result3 = sut.call(newList);
    expect(result3, 1.5);
  });

  test('Calculate combined products promotion', () {
    final result = sut.call(combinedProducts);
    expect(result, 3.5);

    List<ProductEntity> newList = [
      combinedProducts[0],
      combinedProducts[1].copyWith(amount: 2),
      combinedProducts[2].copyWith(amount: 2),
    ];
    final result2 = sut.call(newList);
    expect(result2, 6.5);

    newList = [
      combinedProducts[0],
      combinedProducts[1].copyWith(amount: 3),
      combinedProducts[2].copyWith(amount: 2),
    ];
    final result3 = sut.call(newList);
    expect(result3, 8.0);

    newList = [
      combinedProducts[0],
      combinedProducts[1].copyWith(amount: 2),
      combinedProducts[2].copyWith(amount: 3),
    ];
    final result4 = sut.call(newList);
    expect(result4, 8.5);
  });

  test('Calculate all promotions', () {
    final result = sut.call(allProducstAndPromotions);
    expect(result, 8.0);
  });
}
