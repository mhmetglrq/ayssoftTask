import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_product_app/core/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/product_model.dart';

final productRepositoryProvider = Provider(
  (ref) => ProductRepository(dio: Dio()),
);

class ProductRepository {
  ProductRepository({required this.dio});
  final Dio dio;

  Future<List<ProductModel>> getProducts(
      {int? page, bool? completed, int? limit}) async {
    List<ProductModel> products = [];
    try {
      final response = await http.get(
        Uri.parse(
          '${Constants.productApiBaseUrl}${page != null ? '?completed=$completed&page=$page&limit=$limit' : ''}',
        ),
      );
      if (response.statusCode == 200) {
        final responseData = await compute(jsonDecode, response.body);
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

  Future<List<ProductModel>> searchProducts(String query) async {
    List<ProductModel> products = [];
    try {
      final response = await http.get(
        Uri.parse('${Constants.productApiBaseUrl}?q=$query'),
      );
      if (response.statusCode == 200) {
        final responseData = await compute(jsonDecode, response.body);
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

  Future<List<ProductModel>> getProductsByBrand(String brand) async {
    List<ProductModel> products = [];
    try {
      final response = await http.get(
        Uri.parse('${Constants.productApiBaseUrl}?brand=$brand'),
      );
      if (response.statusCode == 200) {
        final responseData = await compute(jsonDecode, response.body);
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

  Future<void> saveProductToCart(Map<dynamic, dynamic> product) async {
    try {
      final cartBox = Hive.box("cart");
      await cartBox.add(product);
    } catch (e) {
      debugPrint('Hata: $e');
    }
  }

  Future<List<ProductModel>> getCartProducts() async {
    List<ProductModel> products = [];
    try {
      final cartBox = Hive.box("cart");
      for (var i = 0; i < cartBox.length; i++) {
        products.add(ProductModel.fromMap(cartBox.getAt(i)));
      }

      return products;
    } catch (e) {
      debugPrint('Hata:---- $e');
    }
    return products;
  }

  Future<void> deleteProductFromCart(int index) async {
    try {
      final cartBox = Hive.box("cart");
      await cartBox.deleteAt(index);
    } catch (e) {
      debugPrint('Hata: $e');
    }
  }

  Future<void> deleteAllProductsFromCart() async {
    try {
      final cartBox = Hive.box("cart");
      await cartBox.clear();
    } catch (e) {
      debugPrint('Hata: $e');
    }
  }

  Future<void> updateProductFromCart(
      int index, Map<dynamic, dynamic> product) async {
    try {
      final cartBox = Hive.box("cart");
      await cartBox.putAt(index, product);
    } catch (e) {
      debugPrint('Hata: $e');
    }
  }

  int getCartProductCount() {
    try {
      final cartBox = Hive.box("cart");
      return cartBox.length;
    } catch (e) {
      debugPrint('Hata: $e');
    }
    return 0;
  }
}
