import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';
import 'package:flutter_product_app/config/utility/enum/image_enum.dart';
import 'package:flutter_product_app/features/cart/view/cart.dart';
import 'package:flutter_product_app/features/favorites/view/favorites.dart';
import 'package:flutter_product_app/features/product/view/product_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/items/colors.dart';
import '../../product/controller/product_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final bottomNavigationItems = [
    const ProductList(),
    const Cart(),
    const Favorites(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: bottomNavigationItems[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 5,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                ImageConstants.home.toSvg,
                colorFilter: const ColorFilter.mode(
                  AppColors.descriptionGrey,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                ImageConstants.home.toSvg,
                colorFilter: const ColorFilter.mode(
                  AppColors.violet,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor: AppColors.transparent,
                  radius: context.dynamicWidth(0.04),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        ImageConstants.bag.toSvg,
                        colorFilter: const ColorFilter.mode(
                          AppColors.descriptionGrey,
                          BlendMode.srcIn,
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final count = ref
                              .watch(productControllerProvider)
                              .getCartProductCount()
                              .toString();

                          return count == '0'
                              ? const SizedBox()
                              : Align(
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.violet,
                                    radius: context.dynamicWidth(0.021),
                                    child: Text(
                                      count,
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: AppColors.white,
                                        fontSize: context.dynamicWidth(0.020),
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
                activeIcon: CircleAvatar(
                  backgroundColor: AppColors.transparent,
                  radius: context.dynamicWidth(0.04),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        ImageConstants.bag.toSvg,
                        colorFilter: const ColorFilter.mode(
                          AppColors.violet,
                          BlendMode.srcIn,
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final count = ref
                              .watch(productControllerProvider)
                              .getCartProductCount()
                              .toString();

                          return count == '0'
                              ? const SizedBox()
                              : Align(
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.violet,
                                    radius: context.dynamicWidth(0.021),
                                    child: Text(
                                      count,
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: AppColors.white,
                                        fontSize: context.dynamicWidth(0.020),
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
                label: 'Cart'),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                ImageConstants.heart.toSvg,
                colorFilter: const ColorFilter.mode(
                  AppColors.descriptionGrey,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                ImageConstants.heart.toSvg,
                colorFilter: const ColorFilter.mode(
                  AppColors.violet,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
