// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/routes/route_names.dart';
import 'package:flutter_product_app/core/models/cart_item_model.dart';
import 'package:flutter_product_app/features/cart/widget/delivery_address.dart';
import 'package:flutter_product_app/features/favorites/controller/favorites_controller.dart';
import 'package:flutter_product_app/features/product/controller/product_controller.dart';
import 'package:flutter_product_app/features/product/widget/violet_filled_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_product_app/config/extensions/context_extension.dart';
import 'package:flutter_product_app/config/utility/enum/image_enum.dart';
import 'package:lottie/lottie.dart';

import '../../../config/items/colors.dart';
import '../widget/empty_widget.dart';

class Favorites extends ConsumerStatefulWidget {
  const Favorites({super.key});

  @override
  ConsumerState<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends ConsumerState<Favorites> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: context.textTheme.titleLarge?.copyWith(
            fontSize: context.dynamicWidth(0.05),
            color: AppColors.titleBlack,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: context.paddingAllDefault,
        child: Column(
          children: [
            FutureBuilder<List<CartItemModel>>(
                future: ref.read(favoritesControllerProvider).getFavorites(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CartItemModel> favorites = snapshot.data!;
                    if (favorites.isEmpty) {
                      return const EmptyWidget();
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: favorites.length,
                        itemBuilder: (BuildContext context, int index) {
                          final favorite = favorites[index];

                          return _favoriteCard(context, favorite);
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  GestureDetector _favoriteCard(BuildContext context, CartItemModel favorite) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.productDetails,
          arguments: {"productId": favorite.id},
        );
      },
      child: Card(
        elevation: 5,
        surfaceTintColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: context.paddingHorizontalLow,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: favorite.image!,
                  height: context.dynamicHeight(0.10),
                  width: context.dynamicHeight(0.10),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: context.paddingAllDefault,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${favorite.brand!},${favorite.model!}",
                        style: context.textTheme.titleLarge?.copyWith(
                          fontSize: context.dynamicWidth(0.04),
                        ),
                      ),
                      Text(
                        favorite.name!,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontSize: context.dynamicWidth(0.031),
                        ),
                      ),
                      Text(
                        "\$${favorite.price!}",
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontSize: context.dynamicWidth(0.035),
                          color: AppColors.descriptionGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await ref
                      .read(favoritesControllerProvider)
                      .removeFavorite(favorite.id!);
                  ref.refresh(productControllerProvider).getFavorites();
                  setState(() {});
                },
                icon: SvgPicture.asset(
                  ImageConstants.delete.toSvg,
                  height: context.dynamicHeight(0.031),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
