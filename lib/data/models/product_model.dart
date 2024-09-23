import 'package:test_2go_bank/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required int id,
    required String name,
    required double price,
  }) : super(id: id, name: name, price: price);

  ProductEntity toEntity() => ProductEntity(
        id: id,
        name: name,
        price: price,
        promotion: promotion,
      );

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
        id: entity.id,
        name: entity.name,
        price: entity.price,
      );
}
