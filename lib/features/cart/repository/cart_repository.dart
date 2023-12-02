import 'package:flutter/material.dart';
import 'package:flutter_product_app/core/models/cart_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final cartRepositoryProvider = Provider((ref) => CartRepository());

class CartRepository {
  CartRepository();

  Future<List<CartItemModel>> getCartProducts() async {
    List<CartItemModel> cartItems = [];
    try {
      final cartBox = Hive.box("cart");
      for (var i = 0; i < cartBox.length; i++) {
        cartItems.add(CartItemModel.fromMap(cartBox.getAt(i)));
      }

      return cartItems;
    } catch (e) {
      debugPrint('Hata:---- $e');
    }
    return cartItems;
  }

  Future<void> increaseProductQuantity(String cartItemId) async {
    try {
      final cartBox = Hive.box("cart");
      final cartCountBox = Hive.box("cartCount");
      if (cartBox.length > 0 && cartBox.containsKey(cartItemId)) {
        CartItemModel cartItem = CartItemModel.fromMap(cartBox.get(cartItemId));
        cartItem.quantity = cartItem.quantity! + 1;
        await cartBox.put(cartItem.id, cartItem.toMap());
        await cartCountBox.add(cartItem.toMap());
        return;
      }
    } catch (e) {
      debugPrint('Hata: $e');
    }
  }

  Future<void> decreaseProductQuantity(String cartItemId) async {
    try {
      final cartBox = Hive.box("cart");
      final cartCountBox = Hive.box("cartCount");
      if (cartBox.length > 0 && cartBox.containsKey(cartItemId)) {
        CartItemModel cartItem = CartItemModel.fromMap(cartBox.get(cartItemId));
        if (cartItem.quantity! > 1) {
          cartItem.quantity = cartItem.quantity! - 1;
          await cartBox.put(cartItem.id, cartItem.toMap());
          await cartCountBox.deleteAt(cartCountBox.length - 1);
          return;
        } else {
          await cartBox.delete(cartItemId);
          await cartCountBox.delete(cartCountBox.length - 1);
          return;
        }
      }
    } catch (e) {
      debugPrint('Hata: $e');
    }
  }

  Future<void> deleteProductFromCart(String cartItemId) async {
    try {
      final cartBox = Hive.box("cart");
      final cartCountBox = Hive.box("cartCount");
      if (cartBox.length > 0 && cartBox.containsKey(cartItemId)) {
        CartItemModel cartItem = CartItemModel.fromMap(cartBox.get(cartItemId));

        await cartBox.delete(cartItemId);

        for (var i = cartItem.quantity!; i > 0; i--) {
          await cartCountBox.deleteAt(i - 1);
        }

        return;
      }
    } catch (e) {
      debugPrint('Hata: $e');
    }
  }
}
