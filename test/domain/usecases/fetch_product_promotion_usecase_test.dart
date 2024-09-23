import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_2go_bank/domain/usecases/fetch_product_promotion_usecase.dart';

import '../../helpers/test_helper.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late FetchProductPromotionUseCaseImpl sut;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    sut = FetchProductPromotionUseCaseImpl(mockProductRepository);
  });

  test('should get product promotion from the repository', () async {
    when(mockProductRepository.fetchProductPromotion(any))
        .thenAnswer((_) async => const Right(testDiscountPromotion));

    final result = await sut.call(1);

    expect(result.isRight(), true);
    expect(result, const Right(testDiscountPromotion));
  });
}
