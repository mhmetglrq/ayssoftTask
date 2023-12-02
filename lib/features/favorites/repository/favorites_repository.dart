
import 'package:flutter/material.dart';
import 'package:flutter_product_app/core/models/cart_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final favoritesRepositoryProvider=Provider((ref)=>FavoritesRepository());

class FavoritesRepository {
  FavoritesRepository();

  Future<List<CartItemModel>> getFavorites()async{
    List<CartItemModel> favorites = [];
    try {
      final favoritesBox = Hive.box("favorites");
      for (var i = 0; i < favoritesBox.length; i++) {
        favorites.add(CartItemModel.fromMap(favoritesBox.getAt(i)));
      }
      return favorites;
    } catch (e) {
      debugPrint('Error:---- $e');
    }
    return favorites;
  }

  Future<void> addFavorite(CartItemModel cartItem) async {
    try {
      final favoritesBox = Hive.box("favorites");
      if (favoritesBox.length > 0 && favoritesBox.containsKey(cartItem.id)) {
        return;
      } else {
        await favoritesBox.put(cartItem.id, cartItem.toMap());
        return;
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> removeFavorite(String cartItemId) async {
    try {
      final favoritesBox = Hive.box("favorites");
      if (favoritesBox.length > 0 && favoritesBox.containsKey(cartItemId)) {
        await favoritesBox.delete(cartItemId);
        return;
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

}