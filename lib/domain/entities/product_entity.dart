import 'package:equatable/equatable.dart';

import 'promotion_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final double price;
  final int amount;
  final PromotionEntity? promotion;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    this.amount = 1,
    this.promotion,
  });

  @override
  List<Object?> get props => [id, name, price, amount, promotion];

  ProductEntity copyWith({
    int? id,
    String? name,
    double? price,
    int? amount,
    PromotionEntity? promotion,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      promotion: promotion ?? this.promotion,
    );
  }
}
