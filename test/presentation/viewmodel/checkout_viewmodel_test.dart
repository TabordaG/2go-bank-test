import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_2go_bank/core/error/failure.dart';
import 'package:test_2go_bank/presentation/viewmodel/checkout_viewmodel.dart';

import '../../helpers/test_helper.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late CheckoutViewModel sut;
  late MockFetchProductUseCaseImpl mockFetchProductUseCaseImpl;
  late MockFetchProductPromotionUseCaseImpl
      mockFetchProductPromotionUseCaseImpl;
  late MockCalculatePurchaseTotalUsecaseImpl
      mockCalculatePurchaseTotalUsecaseImpl;

  setUp(() {
    mockFetchProductUseCaseImpl = MockFetchProductUseCaseImpl();
    mockFetchProductPromotionUseCaseImpl =
        MockFetchProductPromotionUseCaseImpl();
    mockCalculatePurchaseTotalUsecaseImpl =
        MockCalculatePurchaseTotalUsecaseImpl();
    sut = CheckoutViewModel(
      mockFetchProductUseCaseImpl,
      mockFetchProductPromotionUseCaseImpl,
      mockCalculatePurchaseTotalUsecaseImpl,
    );
  });

  test('initial state should be empty', () {
    expect(sut.purchase.items, isEmpty);
  });

  test('add a new product with no promotion', () async {
    when(mockFetchProductUseCaseImpl(any))
        .thenAnswer((_) async => Right(testProducts[0]));
    when(mockFetchProductPromotionUseCaseImpl(any)).thenAnswer(
        (_) async => const Left(DatabaseFailure('Promotion not found')));
    when(mockCalculatePurchaseTotalUsecaseImpl(any))
        .thenAnswer((_) => testProducts[0].price);

    await sut.addProduct(1);

    expect(sut.purchase.items.length, 1);
    expect(sut.purchase.total, testProducts[0].price);
  });

  test('add a new product with promotion', () async {
    when(mockFetchProductUseCaseImpl(any))
        .thenAnswer((_) async => Right(testProducts[0]));
    when(mockFetchProductPromotionUseCaseImpl(any))
        .thenAnswer((_) async => Right(testPromotions[0]));
    when(mockCalculatePurchaseTotalUsecaseImpl(any))
        .thenAnswer((_) => testProducts[0].price);

    await sut.addProduct(1);

    expect(sut.purchase.items.length, 1);
  });

  test('add different products more than once with no promotion', () async {
    when(mockFetchProductUseCaseImpl(1))
        .thenAnswer((_) async => Right(testProducts[0]));
    when(mockFetchProductUseCaseImpl(2))
        .thenAnswer((_) async => Right(testProducts[1]));

    when(mockFetchProductPromotionUseCaseImpl(1))
        .thenAnswer((_) async => Right(testPromotions[0]));
    when(mockFetchProductPromotionUseCaseImpl(2))
        .thenAnswer((_) async => Right(testPromotions[1]));

    when(mockCalculatePurchaseTotalUsecaseImpl(any)).thenAnswer(
        (_) => (testProducts[0].price * 3) + (testProducts[1].price * 2));

    await sut.addProduct(1);
    await sut.addProduct(2);
    await sut.addProduct(1);
    await sut.addProduct(2);
    await sut.addProduct(1);

    expect(sut.purchase.items.length, 2);
    expect(sut.purchase.total,
        (testProducts[0].price * 3) + (testProducts[1].price * 2));
  });

  test('add different products more than once with promotion', () async {
    when(mockFetchProductUseCaseImpl(1))
        .thenAnswer((_) async => Right(testProducts[0]));
    when(mockFetchProductUseCaseImpl(2))
        .thenAnswer((_) async => Right(testProducts[1]));

    when(mockFetchProductPromotionUseCaseImpl(1)).thenAnswer(
        (_) async => const Left(DatabaseFailure('Promotion not found')));
    when(mockFetchProductPromotionUseCaseImpl(2))
        .thenAnswer((_) async => Right(testPromotions[0]));

    when(mockCalculatePurchaseTotalUsecaseImpl(any)).thenAnswer(
        (_) => (testProducts[0].price * 3) + (testProducts[1].price * 2));

    await sut.addProduct(1);
    await sut.addProduct(2);
    await sut.addProduct(1);
    await sut.addProduct(2);
    await sut.addProduct(1);

    expect(sut.purchase.items.length, 2);
    expect(sut.purchase.total,
        (testProducts[0].price * 3) + (testProducts[1].price * 2));
  });
}
