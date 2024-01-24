import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';
import 'package:flutter_product_app/config/routes/route_names.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/items/colors.dart';
import '../../../config/utility/enum/image_enum.dart';
import '../../../core/models/product_model.dart';
import '../controller/product_controller.dart';

class CustomAppbar extends ConsumerStatefulWidget {
  const CustomAppbar({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  ConsumerState<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends ConsumerState<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllDefault,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.white,
            radius: context.dynamicWidth(0.065),
            child: IconButton(
              onPressed: () {
                ref.refresh(productControllerProvider).getFavorites();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.home, (route) => false);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.titleBlack,
              ),
            ),
          ),
          const Spacer(),
          Consumer(
            builder: (context, ref, child) {
              final favorites =
                  ref.read(productControllerProvider).getFavorites();
              final isFavorite =
                  favorites.any((element) => element.id == widget.product.id);
              return isFavorite
                  ? Padding(
                      padding: context.paddingHorizontalLow,
                      child: GestureDetector(
                        onTap: () async {
                          await ref
                              .read(productControllerProvider)
                              .removeFavorite(widget.product.id!);

                          setState(() {});
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.white,
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
                  : Padding(
                      padding: context.paddingHorizontalLow,
                      child: GestureDetector(
                        onTap: () async {
                          await ref
                              .read(productControllerProvider)
                              .addFavorite(widget.product);

                          setState(() {});
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.white,
                          radius: context.dynamicWidth(0.065),
                          child: SvgPicture.asset(
                            ImageConstants.heart.toSvg,
                          ),
                        ),
                      ),
                    );
            },
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.cart);
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.white,
                  radius: context.dynamicWidth(0.065),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        ImageConstants.bag.toSvg,
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              backgroundColor: AppColors.violet,
                              radius: context.dynamicWidth(0.028),
                              child: Text(
                                ref
                                    .watch(productControllerProvider)
                                    .getCartProductCount()
                                    .toString(),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.white,
                                  fontSize: context.dynamicWidth(0.035),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
