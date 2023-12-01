import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';
import 'package:flutter_product_app/config/items/colors.dart';
import 'package:flutter_product_app/core/models/product_model.dart';
import 'package:flutter_product_app/features/product/controller/product_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widget/custom_appbar.dart';
import '../widget/violet_filled_button.dart';

class ProductDetails extends ConsumerWidget {
  const ProductDetails({
    Key? key,
    required this.productId,
  }) : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<ProductModel>(
          future: ref.read(productControllerProvider).getProduct(productId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final product = snapshot.data!;
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: product.image!,
                              height: context.dynamicHeight(0.5),
                              width: context.dynamicWidth(1),
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: context.paddingAllDefault,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.model!,
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: AppColors.titleBlack,
                                          fontSize: context.dynamicWidth(0.04),
                                        ),
                                      ),
                                      Text(
                                        product.name!,
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: AppColors.titleBlack,
                                          fontSize: context.dynamicWidth(0.048),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Price",
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: AppColors.titleBlack,
                                          fontSize: context.dynamicWidth(0.036),
                                        ),
                                      ),
                                      Text(
                                        "\$${product.price}",
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: AppColors.titleBlack,
                                          fontSize: context.dynamicWidth(0.042),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: context.paddingHorizontalDefault,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Description",
                            style: context.textTheme.titleMedium?.copyWith(
                              color: AppColors.titleBlack,
                              fontSize: context.dynamicWidth(0.045),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: context.paddingAllDefault,
                          child: Text(
                            product.description!,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.descriptionGrey,
                              fontSize: context.dynamicWidth(0.036),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: context.dynamicHeight(0.085),
                        ),
                      ],
                    ),
                  ),
                  const CustomAppbar(),
                  SizedBox(
                    width: context.dynamicWidth(1),
                    child: VioletFilledButton(
                      onPressed: () async {
                        ref
                            .read(productControllerProvider)
                            .saveProductToCart(product.toMap());
                        var result = await ref
                            .read(productControllerProvider)
                            .getCartProducts();
                        print(result);
                        ref
                            .refresh(productControllerProvider)
                            .getCartProductCount();
                      },
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
