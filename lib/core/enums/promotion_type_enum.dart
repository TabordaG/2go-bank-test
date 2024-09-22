enum PromotionTypeEnum {
  combinedOfferPromotion('Oferta combinada'),
  discountQuantityPromotion('Compre N unidades e pague Y'),
  buyOneGetOnePromotion('Compre N e ganhe 1');

  final String description;

  const PromotionTypeEnum(this.description);
}
