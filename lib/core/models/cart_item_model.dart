// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartItemModel {
  String? id;
  String? name;
  String? image;
  String? price;
  int? quantity;
  String? brand;
  String? model;
  CartItemModel({
    this.id,
    this.name,
    this.image,
    this.price,
    this.quantity,
    this.brand,
    this.model,
  });

  CartItemModel copyWith({
    String? id,
    String? name,
    String? image,
    String? price,
    int? quantity,
    String? brand,
    String? model,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      brand: brand ?? this.brand,
      model: model ?? this.model,
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'brand': brand,
      'model': model,
    };
  }

  factory CartItemModel.fromMap(Map<dynamic, dynamic> map) {
    return CartItemModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItemModel(id: $id, name: $name, image: $image, price: $price, quantity: $quantity, brand: $brand, model: $model)';
  }

  @override
  bool operator ==(covariant CartItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.price == price &&
        other.quantity == quantity &&
        other.brand == brand &&
        other.model == model;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        brand.hashCode ^
        model.hashCode;
  }
}
