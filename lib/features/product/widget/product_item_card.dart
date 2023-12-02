import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';
import 'package:flutter_product_app/features/product/controller/product_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/items/colors.dart';
import '../../../config/routes/route_names.dart';
import '../../../config/utility/enum/image_enum.dart';
import '../../../core/models/product_model.dart';

class ProductItemCard extends StatefulWidget {
  const ProductItemCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RouteNames.productDetails,
          arguments: {"productId": widget.product.id}),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              height: context.dynamicHeight(0.4),
              imageUrl: widget.product.image!,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final favorites =
                  ref.read(productControllerProvider).getFavorites();
              final isFavorite =
                  favorites.any((element) => element.id == widget.product.id);
              return isFavorite
                  ? Container(
                      padding: EdgeInsets.all(context.dynamicWidth(0.01)),
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () async {
                          await ref
                              .read(productControllerProvider)
                              .removeFavorite(widget.product.id!);
                          setState(() {});
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.white.withOpacity(0.3),
                          radius: context.dynamicWidth(0.065),
                          child: SvgPicture.asset(
                            ImageConstants.heart.toSvg,
                            colorFilter: const ColorFilter.mode(
                              Colors.red,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(context.dynamicWidth(0.01)),
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () async {
                          await ref
                              .read(productControllerProvider)
                              .addFavorite(widget.product);
                          setState(() {});
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.white.withOpacity(0.3),
                          radius: context.dynamicWidth(0.065),
                          child: SvgPicture.asset(
                            ImageConstants.heart.toSvg,
                          ),
                        ),
                      ),
                    );
            },
          ),
          Padding(
            padding: context.paddingAllLow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.product.name!,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontSize: context.dynamicWidth(0.04),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.product.price!.toString(),
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
