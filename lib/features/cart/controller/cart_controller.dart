import 'package:flutter_product_app/features/cart/repository/cart_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/cart_item_model.dart';

final cartControllerProvider = Provider(
    (ref) => CartController(cartRepository: ref.read(cartRepositoryProvider)));

class CartController {
  final CartRepository cartRepository;

  CartController({required this.cartRepository});

  Future<List<CartItemModel>> getCartProducts() async {
    return await cartRepository.getCartProducts();
  }

  Future<void> increaseProductQuantity(String cartItemId) async {
    await cartRepository.increaseProductQuantity(cartItemId);
  }

  Future<void> decreaseProductQuantity(String cartItemId) async {
    await cartRepository.decreaseProductQuantity(cartItemId);
  }

  Future<void> deleteProductFromCart(String cartItemId) async {
    await cartRepository.deleteProductFromCart(cartItemId);
  }
}
