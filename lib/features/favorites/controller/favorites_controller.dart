import 'package:flutter_product_app/features/favorites/repository/favorites_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/cart_item_model.dart';

final favoritesControllerProvider = Provider((ref) => FavoritesController(
    favoritesRepository: ref.watch(favoritesRepositoryProvider)));

class FavoritesController {
  final FavoritesRepository favoritesRepository;

  FavoritesController({required this.favoritesRepository});


  Future<List<CartItemModel>> getFavorites()async{
    return await favoritesRepository.getFavorites();
  }

  Future<void> addFavorite(CartItemModel cartItem) async {
    await favoritesRepository.addFavorite(cartItem);
  }

  Future<void> removeFavorite(String cartItemId) async {
    await favoritesRepository.removeFavorite(cartItemId);
  }
}
