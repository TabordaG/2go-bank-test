import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:test_2go_bank/core/utils/toast.dart';
import 'package:test_2go_bank/domain/entities/product_entity.dart';
import 'package:test_2go_bank/domain/entities/purchase_entity.dart';

import '../../domain/usecases/calculate_purchase_total_usecase.dart';
import '../../domain/usecases/fetch_product_promotion_usecase.dart';
import '../../domain/usecases/fetch_product_usecase.dart';

part 'checkout_viewmodel.g.dart';

class CheckoutViewModel = CheckoutViewModelBase with _$CheckoutViewModel;

abstract class CheckoutViewModelBase with Store {
  final FetchProductUseCase _fetchProductUseCase;
  final FetchProductPromotionUseCase _fetchProductPromotionUseCase;
  final CalculatePurchaseTotalUsecase _calculatePurchaseTotalUsecase;

  CheckoutViewModelBase(
    this._fetchProductUseCase,
    this._fetchProductPromotionUseCase,
    this._calculatePurchaseTotalUsecase,
  );

  /// ----------------------------------------- Observable Variables

  @observable
  TextEditingController productIdController = TextEditingController();

  @observable
  var purchase = PurchaseEntity(
    id: 1,
    date: DateTime.now(),
    items: const [],
  );

  /// ----------------------------------------- Add Product to Purchase

  void clearProductIdController() {
    productIdController.clear();
  }

  /// Adds a product to the purchase list by its product ID.
  /// It first checks if the product already exists in the purchase list:
  /// - If the product exists, it increments the amount of the existing product.
  /// - If the product does not exist, it fetches the product details and adds it to the purchase list.
  @action
  Future<void> addProduct(int productId) async {
    int index = purchase.items.indexWhere((element) => element.id == productId);
    if (index != -1) {
      purchase.items[index] = purchase.items[index]
          .copyWith(amount: purchase.items[index].amount + 1);
    } else {
      final newProduct = await fetchProduct(productId);
      if (newProduct != null) {
        purchase = purchase.copyWith(items: [
          ...purchase.items,
          newProduct,
        ]);
      }
    }

    updatePurchaseTotal();
  }

  /// Fetches a product by its ID and applies any available promotions.
  /// Returns the product with the applied promotion or null if not found.
  @action
  Future<ProductEntity?> fetchProduct(int productId) async {
    final fetchProductResult = await _fetchProductUseCase(productId);

    ProductEntity? product;

    // Handle the result of fetching the product
    fetchProductResult.fold(
      (failure) {
        toastError(message: failure.message);
      },
      (fetchedProduct) {
        // If the product is found, assign it to the product variable
        product = fetchedProduct;
      },
    );

    // If the product is not found, return null
    if (product == null) return null;

    // Fetch the promotion for the product using the use case
    final fetchPromotionResult =
        await _fetchProductPromotionUseCase(product!.id);

    // Handle the result of fetching the promotion
    fetchPromotionResult.fold(
      (failure) {},
      (promotion) {
        // If the promotion is found, apply it to the product
        product = product!.copyWith(promotion: promotion);
      },
    );

    // Return the product with the applied promotion
    return product;
  }

  /// ----------------------------------------- Update Product Amount

  void updateProductAmount(int productId, int value) {
    int index = purchase.items.indexWhere((element) => element.id == productId);
    if (index != -1) {
      purchase.items[index] = purchase.items[index]
          .copyWith(amount: purchase.items[index].amount + value);
    }

    updatePurchaseTotal();
  }

  /// ----------------------------------------- Remove Product from Purchase

  void removeProduct(int productId) {
    int index = purchase.items.indexWhere((element) => element.id == productId);
    purchase =
        purchase.copyWith(items: List.from(purchase.items)..removeAt(index));

    updatePurchaseTotal();
  }

  /// ----------------------------------------- Calculate Total

  @action
  void updatePurchaseTotal() {
    List<ProductEntity> products = List.from(purchase.items);
    double total = _calculatePurchaseTotalUsecase(products);
    purchase = purchase.copyWith(total: total, date: DateTime.now());
  }
}
