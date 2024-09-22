import 'package:test_2go_bank/data/models/product_model.dart';
import 'package:test_2go_bank/domain/entities/purchase_entity.dart';

class PurchaseModel extends PurchaseEntity {
  const PurchaseModel({
    required int id,
    required DateTime date,
    required double total,
    required List<ProductModel> items,
  }) : super(id: id, date: date, total: total, items: items);

  PurchaseEntity toEntity() => PurchaseEntity(
        id: id,
        date: date,
        total: total,
        items: items.cast<ProductModel>().map((e) => e.toEntity()).toList(),
      );

  factory PurchaseModel.fromEntity(PurchaseEntity entity) => PurchaseModel(
        id: entity.id,
        date: entity.date,
        items: entity.items.map((e) => ProductModel.fromEntity(e)).toList(),
        total: entity.total,
      );
}
