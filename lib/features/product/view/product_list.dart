import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';
import 'package:flutter_product_app/config/items/colors.dart';
import 'package:flutter_product_app/core/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/product_controller.dart';
import '../widget/product_item_card.dart';
import '../widget/shimmer_gridview.dart';

class ProductList extends ConsumerStatefulWidget {
  const ProductList({super.key});

  @override
  ConsumerState<ProductList> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  bool isLoading = true;
  int itemCount = 12;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ürünler',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontSize: context.dynamicWidth(0.06),
                    ),
                  ),
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
              FutureBuilder<List<ProductModel>>(
                future: ref.read(productControllerProvider).getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int lengthDiff = snapshot.data!.length % itemCount;
                    final products = snapshot.data!;

                    _scrollController.addListener(() {
                      if (_scrollController.position.pixels ==
                          _scrollController.position.maxScrollExtent) {
                        setState(() {
                          if (itemCount < products.length - lengthDiff) {
                            itemCount += 12;
                            isLoading = true;
                          } else {
                            itemCount = products.length - 1;
                          }
                        });
                      }
                    });
                    isLoading = false;
                    return Expanded(
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: context.dynamicWidth(0.02),
                          mainAxisSpacing: context.dynamicHeight(0.02),
                        ),
                        itemCount: itemCount + 1,
                        itemBuilder: (BuildContext context, int index) {
                          final product = products[index];
                          return ProductItemCard(product: product);
                        },
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Expanded(child: ShimmerGridview());
                  }
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontSize: context.dynamicWidth(0.04),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
