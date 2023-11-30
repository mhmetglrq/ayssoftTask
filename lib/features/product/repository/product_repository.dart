import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_product_app/core/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/product_model.dart';

final productRepositoryProvider = Provider(
  (ref) => ProductRepository(),
);

class ProductRepository {
  ProductRepository();

  Future<List<ProductModel>> getProducts() async {
    List<ProductModel> products = [];
    try {
      final response = await http.get(
        Uri.parse(Constants.productApiBaseUrl),
      );
      if (response.statusCode == 200) {
        // Gelen veriyi map'e çeviriyoruz
        final responseData = await compute(jsonDecode, response.body);
        // Map'teki verileri model'e çeviriyoruz
        for (var product in responseData) {
          products.add(ProductModel.fromJson(product));
        }
        return products;
      } else {
        debugPrint('Hata kodu: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Hata: $e');
    }
    return products;
  }

  Future<ProductModel> getProduct(String productId) async {
    ProductModel product = ProductModel();
    try {
      final response = await http.get(
        Uri.parse('${Constants.productApiBaseUrl}/$productId'),
      );
      if (response.statusCode == 200) {
        // Gelen veriyi map'e çeviriyoruz
        final responseData = await compute(jsonDecode, response.body);
        // Map'teki verileri model'e çeviriyoruz
        product = ProductModel.fromJson(responseData);
        return product;
      } else {
        debugPrint('Hata kodu: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Hata: $e');
    }
    return product;
  }
}
