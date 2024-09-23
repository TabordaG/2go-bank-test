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
    this.total = 0.0,
    required this.items,
  });

  @override
  List<Object?> get props => [id, date, total, items];

  PurchaseEntity copyWith({
    int? id,
    DateTime? date,
    double? total,
    List<ProductEntity>? items,
  }) {
    return PurchaseEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      total: total ?? this.total,
      items: items ?? this.items,
    );
  }
}
