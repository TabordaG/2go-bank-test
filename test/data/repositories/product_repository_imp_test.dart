import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_2go_bank/data/models/product_model.dart';
import 'package:test_2go_bank/data/repositories/product_repository_imp.dart';

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
    expect(result, const Right(testProduct));
  });

  test('should return a failure when the product is not found', () async {
    when(mockProductRemoteDataSource.fetchProduct(any)).thenThrow(Exception());

    final result = await sut.fetchProduct(1);

    expect(result.isLeft(), true);
  });
}
