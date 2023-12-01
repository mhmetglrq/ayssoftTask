import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';
import 'package:flutter_product_app/config/routes/route_names.dart';
import 'package:flutter_product_app/config/routes/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/items/colors.dart';
import '../../../config/utility/enum/image_enum.dart';
import '../controller/product_controller.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: context.paddingAllDefault,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.white,
            radius: context.dynamicWidth(0.065),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.titleBlack,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, RouteNames.cart),
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
    );
  }
}
