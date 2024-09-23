import 'package:collection/collection.dart';
import 'package:test_2go_bank/core/error/failure.dart';
import 'package:test_2go_bank/data/models/product_model.dart';
import 'package:test_2go_bank/data/models/promotion_model.dart';

import '../../core/enums/promotion_type_enum.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> fetchProduct(int id);
  Future<PromotionModel> fetchProductPromotion(int productId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<ProductModel> fetchProduct(int id) {
    final product =
        mockedProducts.firstWhereOrNull((element) => element.id == id);

    if (product != null) {
      return Future.value(product);
    } else {
      throw const DatabaseFailure('Produto não encontrado!');
    }
  }

  @override
  Future<PromotionModel> fetchProductPromotion(int productId) {
    final promotion = mockedPromotions
        .firstWhereOrNull((element) => element.productId == productId);

    if (promotion != null) {
      return Future.value(promotion);
    } else {
      throw const DatabaseFailure('Promoção não encontrada!');
    }
  }
}

List<ProductModel> mockedProducts = [
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

List<PromotionModel> mockedPromotions = [
  const DiscountQuantityPromotionModel(
    id: 1,
    productId: 2,
    type: PromotionTypeEnum.discountQuantityPromotion,
    minQuantity: 2,
    promotionalPrice: 1.25,
  ),
  const BuyOneGetOnePromotionModel(
    id: 2,
    productId: 3,
    type: PromotionTypeEnum.buyOneGetOnePromotion,
    requiredQuantity: 3,
    freeQuantity: 1,
  ),
  const CombinedOfferPromotionModel(
    id: 3,
    productId: 4,
    type: PromotionTypeEnum.combinedOfferPromotion,
    combinedProductId: 5,
    combinedPrice: 3.0,
  ),
];
