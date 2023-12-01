import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_product_app/core/models/cart_item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
      final response = await dio.get(
        '${Constants.productApiBaseUrl}/products${page != null ? '?completed=false&page=$page&limit=$limit' : ''}',
      );
      if (response.statusCode == 200) {
        final responseData = response.data;
        for (var product in responseData) {
          products.add(ProductModel.fromJson(product));
        }
        return products;
      } else {
        debugPrint('Error code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return products;
  }

  Future<ProductModel> getProduct(String productId) async {
    ProductModel product = ProductModel();
    try {
      final response =
          await dio.get('${Constants.productApiBaseUrl}/products/$productId');
      if (response.statusCode == 200) {
        final responseData = await response.data;
        product = ProductModel.fromJson(responseData);
        return product;
      } else {
        debugPrint('Error code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Hata: $e');
    }
    return product;
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    List<ProductModel> products = [];
    try {
      final response = await dio.get(
        '${Constants.productApiBaseUrl}/products?name=$query',
      );
      if (response.statusCode == 200) {
        final responseData = response.data;
        for (var product in responseData) {
          products.add(ProductModel.fromJson(product));
        }
        return products;
      } else {
        debugPrint('Error code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return products;
  }

  Future<void> saveProductToCart(ProductModel product) async {
    try {
      final cartBox = Hive.box("cart");
      final cartCountBox = Hive.box("cartCount");
      if (cartBox.length > 0 && !cartBox.containsKey(product.id)) {
        CartItemModel cartItem = CartItemModel(
          id: product.id,
          name: product.name,
          image: product.image,
          price: product.price,
          quantity: 1,
          brand: product.brand,
          model: product.model,
        );
        await cartBox.put(cartItem.id, cartItem.toMap());
        await cartCountBox.add(product.toMap());
      } else if (cartBox.length > 0 && cartBox.containsKey(product.id)) {
        CartItemModel cartItem = CartItemModel.fromMap(cartBox.get(product.id));
        cartItem.quantity = cartItem.quantity! + 1;
        await cartBox.put(product.id, cartItem.toMap());
        await cartCountBox.add(product.toMap());

        return;
      } else {
        CartItemModel cartItem = CartItemModel(
          id: product.id,
          name: product.name,
          image: product.image,
          price: product.price,
          quantity: 1,
          brand: product.brand,
          model: product.model,
        );
        await cartBox.put(cartItem.id, cartItem.toMap());
        await cartCountBox.add(product.toMap());
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  int getCartProductCount() {
    try {
      final cartCountBox = Hive.box("cartCount");
      return cartCountBox.length;
    } catch (e) {
      debugPrint('Error: $e');
    }
    return 0;
  }
}
