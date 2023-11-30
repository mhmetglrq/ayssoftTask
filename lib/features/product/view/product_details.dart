import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';
import 'package:flutter_product_app/config/items/colors.dart';
import 'package:flutter_product_app/core/models/product_model.dart';
import 'package:flutter_product_app/features/product/controller/product_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        child: Padding(
          padding: context.paddingAllLow,
          child: FutureBuilder<ProductModel>(
            future: ref.read(productControllerProvider).getProduct(productId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final product = snapshot.data!;
                return Column(
                  children: [
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: context.paddingAllLow,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.primary,
                              ),
                            ),
                            const Spacer(),
                            CircleAvatar(
                              backgroundColor: AppColors.primary,
                              radius: context.dynamicWidth(0.05),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.shopping_cart,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white,
                              surfaceTintColor: AppColors.white,
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              shadowColor: Colors.grey.shade300,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: context.paddingAllDefault,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        product.image!,
                                        height: context.dynamicHeight(0.5),
                                        width: context.dynamicWidth(1),
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                    ),
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
                                              product.name!,
                                              style: context
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                color: AppColors.primary,
                                                fontSize:
                                                    context.dynamicWidth(0.042),
                                              ),
                                            ),
                                            Text(
                                              product.model!,
                                              style: context
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                color: AppColors.primary,
                                                fontSize:
                                                    context.dynamicWidth(0.036),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Card(
                                          elevation: 15,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            padding: context.paddingAllLow,
                                            alignment: Alignment.centerRight,
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Text(
                                              "\$ ${product.price}",
                                              style: context
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                color: Colors.white,
                                                fontSize:
                                                    context.dynamicWidth(0.042),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: context.paddingAllDefault,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Description",
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: AppColors.primary,
                                  fontSize: context.dynamicWidth(0.042),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              surfaceTintColor: AppColors.white,
                              shadowColor: Colors.grey.shade300,
                              child: Padding(
                                padding: context.paddingAllDefault,
                                child: Text(
                                  product.description!,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.primary,
                                    fontSize: context.dynamicWidth(0.036),
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ],
                        ),
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
      ),
    );
  }
}
