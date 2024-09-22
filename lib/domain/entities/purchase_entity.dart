import 'package:equatable/equatable.dart';

import 'product_entity.dart';

class PurchaseEntity extends Equatable {
  final int id;
  final DateTime date;
  final double total;
  final List<ProductEntity> items;

  const PurchaseEntity({
    required this.id,
    required this.date,
    required this.total,
    required this.items,
  });

  @override
  List<Object?> get props => [id, date, total, items];
}
