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

  Future<List<ProductModel>> getProducts() async {
    return await productRepository.getProducts();
  }
}
