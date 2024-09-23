import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_2go_bank/core/error/failure.dart';
import 'package:test_2go_bank/data/models/product_model.dart';
import 'package:test_2go_bank/data/repositories/product_repository_imp.dart';
import 'package:test_2go_bank/domain/entities/product_entity.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ProductRepositoryImp sut;
  late MockProductRemoteDataSource mockProductRemoteDataSource;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    sut = ProductRepositoryImp(remoteDataSource: mockProductRemoteDataSource);
  });

  const testProduct = ProductModel(
    id: 1,
    name: 'A',
    price: 0.5,
  );

  test('should return the found product', () async {
    when(mockProductRemoteDataSource.fetchProduct(any))
        .thenAnswer((_) async => testProduct);

    final result = await sut.fetchProduct(1);

    expect(result.isRight(), true);

    ProductEntity? product;
    result.fold((_) {}, (r) => product = r);
    expect(product, testProduct.toEntity());
  });

  test('should return a failure when the product is not found', () async {
    when(mockProductRemoteDataSource.fetchProduct(any))
        .thenThrow(const DatabaseFailure('Produto não encontrado!'));

    final result = await sut.fetchProduct(1);

    expect(result.isLeft(), true);
  });
}
