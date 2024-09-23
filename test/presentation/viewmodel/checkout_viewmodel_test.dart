import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_2go_bank/core/enums/checkout_state_enum.dart';
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
    expect(sut.state, CheckoutStateEnum.initial);
    expect(sut.purchase.items, isEmpty);
  });

  test('add a new product with no promotion', () async {
    when(mockFetchProductUseCaseImpl.call(any))
        .thenAnswer((_) async => Right(testProducts[0]));
    when(mockFetchProductPromotionUseCaseImpl.call(any)).thenAnswer(
        (_) async => const Left(DatabaseFailure('Promotion not found')));

    await sut.addProduct(1);

    expect(sut.purchase.items.length, 1);
    expect(sut.purchase.total, testProducts[0].price);
  });

  test('add a new product with promotion', () async {
    when(mockFetchProductUseCaseImpl.call(any))
        .thenAnswer((_) async => Right(testProducts[0]));
    when(mockFetchProductPromotionUseCaseImpl.call(any))
        .thenAnswer((_) async => Right(testPromotions[0]));

    await sut.addProduct(1);

    expect(sut.purchase.items.length, 1);
  });

  test('add different products more than once with no promotion', () async {
    when(mockFetchProductUseCaseImpl.call(1))
        .thenAnswer((_) async => Right(testProducts[0]));
    when(mockFetchProductUseCaseImpl.call(2))
        .thenAnswer((_) async => Right(testProducts[1]));
    when(mockFetchProductPromotionUseCaseImpl.call(1))
        .thenAnswer((_) async => Right(testPromotions[0]));

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
    when(mockFetchProductUseCaseImpl.call(1))
        .thenAnswer((_) async => Right(testProducts[0]));
    when(mockFetchProductUseCaseImpl.call(2))
        .thenAnswer((_) async => Right(testProducts[1]));

    when(mockFetchProductPromotionUseCaseImpl.call(1)).thenAnswer(
        (_) async => const Left(DatabaseFailure('Promotion not found')));
    when(mockFetchProductPromotionUseCaseImpl.call(2))
        .thenAnswer((_) async => Right(testPromotions[0]));

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
