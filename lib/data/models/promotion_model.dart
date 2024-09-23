import '../../core/enums/promotion_type_enum.dart';
import '../../domain/entities/promotion_entity.dart';

class PromotionModel extends PromotionEntity {
  const PromotionModel({
    required int id,
    required int productId,
    required PromotionTypeEnum type,
  }) : super(id: id, productId: productId, type: type);

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    switch (json['promotion_type']) {
      case 'discountQuantityPromotion':
        return DiscountQuantityPromotionModel.fromJson(json);
      case 'buyOneGetOnePromotion':
        return BuyOneGetOnePromotionModel.fromJson(json);
      case 'combinedOfferPromotion':
        return CombinedOfferPromotionModel.fromJson(json);
      default:
        throw Exception('Invalid promotion type');
    }
  }

  PromotionEntity toEntity() {
    switch (type) {
      case PromotionTypeEnum.discountQuantityPromotion:
        return DiscountQuantityPromotionEntity(
          id: id,
          productId: productId,
          quantity: (this as DiscountQuantityPromotionModel).minQuantity,
          promotionalPrice:
              (this as DiscountQuantityPromotionModel).promotionalPrice,
        );
      case PromotionTypeEnum.buyOneGetOnePromotion:
        return BuyOneGetOnePromotionEntity(
          id: id,
          productId: productId,
          requiredQuantity:
              (this as BuyOneGetOnePromotionModel).requiredQuantity,
          freeQuantity: (this as BuyOneGetOnePromotionModel).freeQuantity,
        );
      case PromotionTypeEnum.combinedOfferPromotion:
        return CombinedOfferPromotionEntity(
          id: id,
          productId: productId,
          combinedProductId:
              (this as CombinedOfferPromotionModel).combinedProductId,
          combinedPrice: (this as CombinedOfferPromotionModel).combinedPrice,
        );
    }
  }
}

class DiscountQuantityPromotionModel extends PromotionModel {
  final int minQuantity;
  final double promotionalPrice;

  const DiscountQuantityPromotionModel({
    required int id,
    required int productId,
    required PromotionTypeEnum type,
    required this.minQuantity,
    required this.promotionalPrice,
  }) : super(id: id, productId: productId, type: type);

  factory DiscountQuantityPromotionModel.fromJson(Map<String, dynamic> json) {
    return DiscountQuantityPromotionModel(
      id: json['id'],
      productId: json['product_id'],
      type: PromotionTypeEnum.discountQuantityPromotion,
      minQuantity: json['min_quantity'],
      promotionalPrice: json['promotional_price'],
    );
  }
}

class BuyOneGetOnePromotionModel extends PromotionModel {
  final int requiredQuantity;
  final int freeQuantity;

  const BuyOneGetOnePromotionModel({
    required int id,
    required int productId,
    required PromotionTypeEnum type,
    required this.requiredQuantity,
    this.freeQuantity = 1,
  }) : super(id: id, productId: productId, type: type);

  factory BuyOneGetOnePromotionModel.fromJson(Map<String, dynamic> json) {
    return BuyOneGetOnePromotionModel(
      id: json['id'],
      productId: json['product_id'],
      type: PromotionTypeEnum.buyOneGetOnePromotion,
      requiredQuantity: json['required_quantity'],
      freeQuantity: json['free_quantity'],
    );
  }
}

class CombinedOfferPromotionModel extends PromotionModel {
  final int? combinedProductId;
  final double combinedPrice;

  const CombinedOfferPromotionModel({
    required int id,
    required int productId,
    required PromotionTypeEnum type,
    required this.combinedProductId,
    required this.combinedPrice,
  }) : super(id: id, productId: productId, type: type);

  factory CombinedOfferPromotionModel.fromJson(Map<String, dynamic> json) {
    return CombinedOfferPromotionModel(
      id: json['id'],
      productId: json['product_id'],
      type: PromotionTypeEnum.combinedOfferPromotion,
      combinedProductId: json['product_id_combined'],
      combinedPrice: json['combined_price'],
    );
  }
}

/*
Join Promotion Table and Type Promotion Table

Discount Quantity Promotion
json: {
  "id": 1,
  "product_id": 1,
  "promotion_type": "discountQuantityPromotion",
  "min_quantity": 3,
  "promotional_price": 1.25
}

Buy One Get One Promotion
json: {
  "id": 2,
  "product_id": 2,
  "promotion_type": "buyOneGetOnePromotion",
  "required_quantity": 2,
  "free_quantity": 1
}

Combined Offer Promotion - Buy C and D for 2.5
json: {
  "id": 3,
  "product_id": 3,
  "promotion_type": "combinedOfferPromotion",
  "product_id_combined": 4,
  "combined_price": 2.5
}

NOTE: NOT USE THIS! WHEN IS COMBINED OFFER PROMOTION, CREATE ONLY ONE PROMOTION
ON PROMOTION TABLE, NOT TWO PROMOTIONS. USE THE PRODUCT_IDS TO KNOW WHICH
PRODUCTS ARE IN THE COMBINED OFFER PROMOTION.

Combined Offer Promotion - Buy D and C for 2.5
json: {
  "id": 4,
  "product_id": 4,
  "promotion_type": "combinedOfferPromotion",
  "product_id_combined": 3,
  "combined_price": 2.5
}
*/