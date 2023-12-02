import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';

import '../../../config/routes/route_names.dart';
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
      onTap: () => Navigator.pushNamed(context, RouteNames.productDetails,
          arguments: {"productId": product.id}),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              height: context.dynamicHeight(0.4),
              imageUrl: product.image!,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: context.paddingAllLow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    product.price!.toString(),
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
    );
  }
}
