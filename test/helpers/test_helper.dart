import 'package:mockito/annotations.dart';
import 'package:test_2go_bank/core/enums/promotion_type_enum.dart';
import 'package:test_2go_bank/data/data_sources/remote_data_source.dart';
import 'package:test_2go_bank/data/models/product_model.dart';
import 'package:test_2go_bank/data/models/promotion_model.dart';
import 'package:test_2go_bank/domain/entities/product_entity.dart';
import 'package:test_2go_bank/domain/entities/promotion_entity.dart';
import 'package:test_2go_bank/domain/repositories/product_repository.dart';
import 'package:test_2go_bank/domain/usecases/calculate_purchase_total_usecase.dart';
import 'package:test_2go_bank/domain/usecases/fetch_product_promotion_usecase.dart';
import 'package:test_2go_bank/domain/usecases/fetch_product_usecase.dart';

@GenerateMocks([
  FetchProductUseCaseImpl,
  FetchProductPromotionUseCaseImpl,
  CalculatePurchaseTotalUsecaseImpl,
  ProductRepository,
  ProductRemoteDataSource,
])
void main() {}

const testDiscountPromotion = DiscountQuantityPromotionModel(
  id: 1,
  productId: 2,
  type: PromotionTypeEnum.discountQuantityPromotion,
  minQuantity: 2,
  promotionalPrice: 1.25,
);

const testProduct = ProductEntity(
  id: 1,
  name: 'Test Product',
  price: 1000,
);

List<ProductModel> testProducts = [
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

List<ProductEntity> discountedProducts = [
  const ProductEntity(
    id: 1,
    name: 'A',
    price: 0.5,
    amount: 1,
  ),
  const ProductEntity(
    id: 2,
    name: 'B',
    price: 0.75,
    amount: 2,
    promotion: DiscountQuantityPromotionEntity(
      id: 1,
      productId: 2,
      quantity: 2,
      promotionalPrice: 1.25,
    ),
  ),
];

List<ProductEntity> buyNgetYProducts = [
  const ProductEntity(
    id: 1,
    name: 'A',
    price: 0.5,
    amount: 1,
  ),
  const ProductEntity(
    id: 3,
    name: 'C',
    price: 0.25,
    amount: 3,
    promotion: BuyOneGetOnePromotionEntity(
      id: 2,
      productId: 3,
      requiredQuantity: 3,
      freeQuantity: 1,
    ),
  ),
];

List<ProductEntity> combinedProducts = [
  const ProductEntity(
    id: 1,
    name: 'A',
    price: 0.5,
    amount: 1,
  ),
  const ProductEntity(
    id: 4,
    name: 'D',
    price: 1.5,
    amount: 1,
    promotion: CombinedOfferPromotionEntity(
      id: 3,
      productId: 4,
      combinedProductId: 5,
      combinedPrice: 3.0,
    ),
  ),
  const ProductEntity(
    id: 5,
    name: 'E',
    price: 2.0,
    amount: 1,
  ),
];

List<ProductEntity> allProducstAndPromotions = [
  const ProductEntity(
    id: 1,
    name: 'A',
    price: 0.5,
    amount: 1,
  ),
  const ProductEntity(
    id: 2,
    name: 'B',
    price: 0.75,
    amount: 3,
    promotion: DiscountQuantityPromotionEntity(
      id: 1,
      productId: 2,
      quantity: 2,
      promotionalPrice: 1.25,
    ),
  ),
  const ProductEntity(
    id: 3,
    name: 'C',
    price: 0.25,
    amount: 5,
    promotion: BuyOneGetOnePromotionEntity(
      id: 2,
      productId: 3,
      requiredQuantity: 3,
      freeQuantity: 1,
    ),
  ),
  const ProductEntity(
    id: 4,
    name: 'D',
    price: 1.5,
    amount: 2,
    promotion: CombinedOfferPromotionEntity(
      id: 3,
      productId: 4,
      combinedProductId: 5,
      combinedPrice: 3.0,
    ),
  ),
  const ProductEntity(
    id: 5,
    name: 'E',
    price: 2.0,
    amount: 1,
  ),
];

List<PromotionModel> testPromotions = [
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
