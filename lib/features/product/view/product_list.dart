import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';
import 'package:flutter_product_app/config/items/colors.dart';
import 'package:flutter_product_app/core/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/product_controller.dart';
import '../widget/product_item_card.dart';

class ProductList extends ConsumerStatefulWidget {
  const ProductList({super.key});

  @override
  ConsumerState<ProductList> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  bool isLoading = false;
  final ScrollController scrollController = ScrollController();
  final TextEditingController minPrice = TextEditingController();
  final TextEditingController maxPrice = TextEditingController();
  List<ProductModel> products = [];
  int page = 1;
  bool bottomSheetVisible = false;
  String? brand;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchData();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  fetchData() async {
    final newProducts = await ref
        .read(productControllerProvider)
        .getProducts(page: page, limit: 12, completed: true);
    setState(() {
      products.addAll(newProducts);
    });
  }

  Future<void> _scrollListener() async {
    if (isLoading) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });
      page += 1;
      await fetchData();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Column(
            children: [
              _searchBar(context),
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: context.dynamicWidth(0.02),
                    mainAxisSpacing: context.dynamicHeight(0.02),
                  ),
                  itemCount: isLoading ? products.length + 1 : products.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < products.length) {
                      final product = products[index];
                      return ProductItemCard(product: product);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _searchBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            onChanged: (query) {
              setState(
                () {
                  ref.read(productControllerProvider).getProducts().then(
                      (value) => products = value
                          .where((element) => element.name!
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList());
                  if (query.isEmpty) {
                    page = 1;
                    fetchData();
                  }
                },
              );
            },
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontSize: context.dynamicWidth(0.04),
            ),
            decoration: InputDecoration(
              contentPadding: context.paddingHorizontalLow,
              hintText: 'Search',
              hintStyle: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontSize: context.dynamicWidth(0.04),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.fillColor,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.violet,
              ),
            ),
          ),
        ),
        SizedBox(width: context.dynamicWidth(0.02)),
        !bottomSheetVisible
            ? GestureDetector(
                onTap: showFilter,
                child: Container(
                  width: context.dynamicWidth(0.1),
                  height: context.dynamicHeight(0.06),
                  decoration: BoxDecoration(
                    color: AppColors.violet,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.filter_alt_outlined,
                    color: AppColors.white,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    bottomSheetVisible = false;
                    page = 1;
                    fetchData();
                  });
                },
                child: Container(
                  width: context.dynamicWidth(0.1),
                  height: context.dynamicHeight(0.06),
                  decoration: BoxDecoration(
                    color: AppColors.violet,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                  ),
                ),
              ),
      ],
    );
  }

  showFilter() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: context.paddingAllDefault,
          height: context.dynamicHeight(0.35),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: context.paddingVerticalLow,
                child: Text(
                  'Filter',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontSize: context.dynamicWidth(0.05),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextField(
                      controller: minPrice,
                      decoration: InputDecoration(
                        hintText: 'Min Price',
                        hintStyle: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontSize: context.dynamicWidth(0.04),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.fillColor,
                      ),
                    ),
                  ),
                  SizedBox(width: context.dynamicWidth(0.02)),
                  Expanded(
                    child: TextField(
                      controller: maxPrice,
                      decoration: InputDecoration(
                        hintText: 'Max Price',
                        hintStyle: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontSize: context.dynamicWidth(0.04),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.fillColor,
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: context.dynamicHeight(0.02)),
              // FutureBuilder<List<ProductModel>>(
              //     future:
              //         ref.read(productControllerProvider).getProducts(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         final products = snapshot.data!;
              //         return Expanded(
              //           child: ListView.builder(
              //             scrollDirection: Axis.horizontal,
              //             itemCount: products.length,
              //             itemBuilder:
              //                 (BuildContext context, int index) {
              //               final item = products[index];
              //               return Padding(
              //                 padding: context.paddingHorizontalLow,
              //                 child: GestureDetector(
              //                   onTap: () {
              //                     setState(() {
              //                       brand = item.brand;
              //                     });
              //                     print(brand);
              //                   },
              //                   child: AnimatedContainer(
              //                     height: context.dynamicHeight(0.04),
              //                     duration:
              //                         const Duration(milliseconds: 300),
              //                     curve: Curves.easeIn,
              //                     decoration: BoxDecoration(
              //                       color: brand == item.brand
              //                           ? AppColors.violet
              //                           : AppColors.fillColor,
              //                       borderRadius:
              //                           BorderRadius.circular(10),
              //                     ),
              //                     padding: context.paddingAllLow,
              //                     child: Text(item.brand!),
              //                   ),
              //                 ),
              //               );
              //             },
              //           ),
              //         );
              //       }
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }),
              SizedBox(height: context.dynamicHeight(0.02)),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: context.dynamicHeight(0.06),
                  decoration: BoxDecoration(
                    color: AppColors.violet,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        bottomSheetVisible = true;
                        ref
                            .read(productControllerProvider)
                            .getProducts()
                            .then((value) {
                          products = value;
                        });
                        products = products
                            .where(
                              (element) =>
                                  double.parse(element.price!) >=
                                      double.parse(minPrice.text) &&
                                  double.parse(element.price!) <
                                      double.parse(maxPrice.text),
                            )
                            .toList();
                        products.sort(
                          (a, b) {
                            return a.price!.compareTo(b.price!);
                          },
                        );
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      'Apply',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontSize: context.dynamicWidth(0.04),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
