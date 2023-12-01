import 'package:flutter_product_app/core/models/product_model.dart';
import 'package:flutter_product_app/features/product/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productControllerProvider = Provider(
  (ref) => ProductController(
    productRepository: ref.watch(productRepositoryProvider),
  ),
);

class ProductController {
  final ProductRepository productRepository;

  ProductController({required this.productRepository});

  Future<List<ProductModel>> getProducts(
      {int? page, bool? completed, int? limit}) async {
    return await productRepository.getProducts(
        page: page, completed: completed, limit: limit);
  }

  Future<ProductModel> getProduct(String productId) async {
    return await productRepository.getProduct(productId);
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    return await productRepository.searchProducts(query);
  }

  Future<List<ProductModel>> getCartProducts() async {
    return await productRepository.getCartProducts();
  }

  Future<void> saveProductToCart(Map<dynamic, dynamic> product) async {
    return await productRepository.saveProductToCart(product);
  }

  int getCartProductCount() {
    return productRepository.getCartProductCount();
  }
}
