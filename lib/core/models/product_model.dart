class ProductModel {
  String? createdAt;
  String? name;
  String? image;
  String? price;
  String? description;
  String? model;
  String? brand;
  String? id;

  ProductModel(
      {this.createdAt,
      this.name,
      this.image,
      this.price,
      this.description,
      this.model,
      this.brand,
      this.id});

  ProductModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
    model = json['model'];
    brand = json['brand'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['name'] = name;
    data['image'] = image;
    data['price'] = price;
    data['description'] = description;
    data['model'] = model;
    data['brand'] = brand;
    data['id'] = id;
    return data;
  }
}
