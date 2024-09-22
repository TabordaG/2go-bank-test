import 'package:equatable/equatable.dart';

import 'promotion_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final double price;
  final PromotionEntity? promotion;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    this.promotion,
  });

  @override
  List<Object?> get props => [id, name, price, promotion];
}
