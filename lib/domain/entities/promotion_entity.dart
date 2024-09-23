import 'package:equatable/equatable.dart';

import '../../core/enums/promotion_type_enum.dart';

class PromotionEntity extends Equatable {
  final int id;
  final int productId;
  final PromotionTypeEnum type;

  const PromotionEntity({
    required this.id,
    required this.productId,
    required this.type,
  });

  @override
  List<Object?> get props => [id, type];
}

class DiscountQuantityPromotionEntity extends PromotionEntity {
  final int quantity;
  final double promotionalPrice;

  const DiscountQuantityPromotionEntity({
    required int id,
    required int productId,
    required this.quantity,
    required this.promotionalPrice,
  }) : super(
            id: id,
            productId: productId,
            type: PromotionTypeEnum.discountQuantityPromotion);

  @override
  List<Object?> get props => super.props..addAll([quantity, promotionalPrice]);
}

class BuyOneGetOnePromotionEntity extends PromotionEntity {
  final int requiredQuantity;
  final int freeQuantity;

  const BuyOneGetOnePromotionEntity({
    required int id,
    required int productId,
    required this.requiredQuantity,
    this.freeQuantity = 1,
  }) : super(
            id: id,
            productId: productId,
            type: PromotionTypeEnum.buyOneGetOnePromotion);

  @override
  List<Object?> get props => super.props
    ..add(requiredQuantity)
    ..add(freeQuantity);
}

class CombinedOfferPromotionEntity extends PromotionEntity {
  final int? combinedProductId;
  final double combinedPrice;

  const CombinedOfferPromotionEntity({
    required int id,
    required int productId,
    required this.combinedProductId,
    required this.combinedPrice,
  }) : super(
            id: id,
            productId: productId,
            type: PromotionTypeEnum.combinedOfferPromotion);

  @override
  List<Object?> get props => super.props
    ..add(combinedProductId)
    ..add(combinedPrice);
}
