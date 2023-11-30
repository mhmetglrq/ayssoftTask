import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';

import '../../../config/items/colors.dart';
import '../../../core/models/product_model.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: AppColors.primary,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                height: context.dynamicHeight(0.3),
                imageUrl: product.image!,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: context.paddingAllLow,
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: context.dynamicWidth(0.05),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: context.paddingAllLow,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product.name!,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontSize: context.dynamicWidth(0.04),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product.price!,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontSize: context.dynamicWidth(0.04),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
