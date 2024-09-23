import 'dart:math';

import '../../core/enums/promotion_type_enum.dart';
import '../entities/product_entity.dart';
import '../entities/promotion_entity.dart';

abstract class CalculatePurchaseTotalUsecase {
  double call(List<ProductEntity> products);
}

class CalculatePurchaseTotalUsecaseImpl
    implements CalculatePurchaseTotalUsecase {
  CalculatePurchaseTotalUsecaseImpl();

  @override
  double call(List<ProductEntity> products) {
    double total = 0.0;

    /// Apply the promotions to the products
    List<ProductEntity> productsWithPromotion =
        products.where((product) => product.promotion != null).toList();

    for (var item in productsWithPromotion) {
      int index = products.indexWhere((element) => element.id == item.id);

      switch (item.promotion!.type) {
        case PromotionTypeEnum.discountQuantityPromotion:
          DiscountQuantityPromotionEntity promotion =
              item.promotion! as DiscountQuantityPromotionEntity;
          while (item.amount >= promotion.quantity) {
            total += promotion.promotionalPrice;
            item = item.copyWith(amount: item.amount - promotion.quantity);
            products[index] = item;
          }
          break;

        case PromotionTypeEnum.buyOneGetOnePromotion:
          BuyOneGetOnePromotionEntity promotion =
              item.promotion! as BuyOneGetOnePromotionEntity;
          while (item.amount >= promotion.requiredQuantity) {
            total += promotion.requiredQuantity * item.price;
            item = item.copyWith(
                amount: max(
                    0,
                    item.amount -
                        promotion.requiredQuantity -
                        promotion.freeQuantity));
            products[index] = item;
          }
          break;

        case PromotionTypeEnum.combinedOfferPromotion:
          CombinedOfferPromotionEntity promotion =
              item.promotion! as CombinedOfferPromotionEntity;
          int indexCombinedProduct = products.indexWhere(
              (element) => element.id == promotion.combinedProductId);
          if (indexCombinedProduct != -1) {
            ProductEntity combinedProduct = products[indexCombinedProduct];
            while (item.amount > 0 && combinedProduct.amount > 0) {
              total += promotion.combinedPrice;
              item = item.copyWith(amount: item.amount - 1);
              combinedProduct =
                  combinedProduct.copyWith(amount: combinedProduct.amount - 1);
              products[index] = item;
              products[indexCombinedProduct] = combinedProduct;
            }
          }
          break;

        default:
          break;
      }
    }

    /// Calculate the total of the remaining products after applying the promotions
    for (var item in products) {
      total += item.price * max(item.amount, 0);
    }

    return total;
  }
}
