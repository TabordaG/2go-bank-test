// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CheckoutViewModel on CheckoutViewModelBase, Store {
  late final _$stateAtom =
      Atom(name: 'CheckoutViewModelBase.state', context: context);

  @override
  CheckoutStateEnum get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CheckoutStateEnum value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$purchaseAtom =
      Atom(name: 'CheckoutViewModelBase.purchase', context: context);

  @override
  PurchaseEntity get purchase {
    _$purchaseAtom.reportRead();
    return super.purchase;
  }

  @override
  set purchase(PurchaseEntity value) {
    _$purchaseAtom.reportWrite(value, super.purchase, () {
      super.purchase = value;
    });
  }

  late final _$addProductAsyncAction =
      AsyncAction('CheckoutViewModelBase.addProduct', context: context);

  @override
  Future<void> addProduct(int productId) {
    return _$addProductAsyncAction.run(() => super.addProduct(productId));
  }

  late final _$fetchProductAsyncAction =
      AsyncAction('CheckoutViewModelBase.fetchProduct', context: context);

  @override
  Future<ProductEntity?> fetchProduct(int productId) {
    return _$fetchProductAsyncAction.run(() => super.fetchProduct(productId));
  }

  late final _$CheckoutViewModelBaseActionController =
      ActionController(name: 'CheckoutViewModelBase', context: context);

  @override
  void updatePurchaseTotal() {
    final _$actionInfo = _$CheckoutViewModelBaseActionController.startAction(
        name: 'CheckoutViewModelBase.updatePurchaseTotal');
    try {
      return super.updatePurchaseTotal();
    } finally {
      _$CheckoutViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
purchase: ${purchase}
    ''';
  }
}
