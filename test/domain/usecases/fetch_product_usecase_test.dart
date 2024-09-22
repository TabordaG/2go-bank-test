import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_2go_bank/domain/entities/product_entity.dart';
import 'package:test_2go_bank/domain/usecases/fetch_product_usecase.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late FetchProductUseCaseImpl sut;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    sut = FetchProductUseCaseImpl(mockProductRepository);
  });

  const testProduct = ProductEntity(
    id: 1,
    name: 'Test Product',
    price: 1000,
  );

  test('should get product from the repository', () async {
    when(mockProductRepository.fetchProduct(any))
        .thenAnswer((_) async => const Right(testProduct));

    final result = await sut.call(1);

    expect(result.isRight(), true);
    expect(result, const Right(testProduct));
  });
}
