import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_app/core/models/cart_item_model.dart';
import 'package:flutter_product_app/features/cart/widget/delivery_address.dart';
import 'package:flutter_product_app/features/product/controller/product_controller.dart';
import 'package:flutter_product_app/features/product/widget/violet_filled_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_product_app/config/extensions/context_extension.dart';
import 'package:flutter_product_app/config/utility/enum/image_enum.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

import '../../../config/items/colors.dart';
import '../controller/cart_controller.dart';
import '../widget/left_title.dart';
import '../widget/order_info.dart';
import '../widget/payment_method.dart';

class Cart extends ConsumerStatefulWidget {
  const Cart({super.key});

  @override
  ConsumerState<Cart> createState() => _CartState();
}

class _CartState extends ConsumerState<Cart> {
  double cartSubtotal = 0;
  double cartTotal = 0;
  bool isEmpty = false;

  @override
  void initState() {
    getCartTotal();

    super.initState();
  }

  void getCartTotal() {
    Future.delayed(Duration.zero, () async {
      final cartBox = Hive.box("cart");
      for (var i = 0; i < cartBox.length; i++) {
        CartItemModel cartItem = CartItemModel.fromMap(cartBox.getAt(i));
        cartSubtotal =
            cartSubtotal + (double.parse(cartItem.price!) * cartItem.quantity!);
        cartTotal = cartSubtotal;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: context.textTheme.titleLarge?.copyWith(
            fontSize: context.dynamicWidth(0.05),
            color: AppColors.titleBlack,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Column(
            children: [
              FutureBuilder<List<CartItemModel>>(
                  future: ref.read(cartControllerProvider).getCartProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<CartItemModel> cartItems = snapshot.data!;
                      if (cartItems.isEmpty) {
                        return Padding(
                          padding: context.paddingVerticalDefault,
                          child: Column(
                            children: [
                              Lottie.asset(
                                "assets/json/empty.json",
                                height: context.dynamicHeight(0.2),
                              ),
                              Text(
                                "Cart is empty!\n Let's add some products",
                                style: context.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          final cartItem = cartItems[index];

                          return _cartItem(context, cartItem, cartItems);
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              const LeftTitle(title: "Delivery Address"),
              const DeliveryAddress(),
              const LeftTitle(
                title: "Payment Method",
              ),
              const PaymentMethod(),
              const LeftTitle(
                title: "Order Info",
              ),
              OrderInfo(cartSubtotal: cartSubtotal, cartTotal: cartTotal),
              VioletFilledButton(
                onPressed: () async {
                  var cartCountbox = Hive.box("cartCount");
                  var cartBox = Hive.box("cart");
                  await cartBox.clear();
                  await cartCountbox.clear();
                  ref.refresh(productControllerProvider).getCartProductCount();
                  setState(() {
                    isEmpty = true;
                  });
                },
                title: "Checkout",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _cartItem(BuildContext context, CartItemModel cartItem,
      List<CartItemModel> cartItems) {
    return Card(
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
                imageUrl: cartItem.image!,
                height: context.dynamicHeight(0.15),
                width: context.dynamicHeight(0.15),
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
                      "${cartItem.brand!},${cartItem.model!}",
                      style: context.textTheme.titleLarge?.copyWith(
                        fontSize: context.dynamicWidth(0.04),
                      ),
                    ),
                    Text(
                      cartItem.name!,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontSize: context.dynamicWidth(0.031),
                      ),
                    ),
                    Text(
                      "\$${cartItem.price!}",
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontSize: context.dynamicWidth(0.035),
                        color: AppColors.descriptionGrey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await ref
                                    .refresh(cartControllerProvider)
                                    .decreaseProductQuantity(cartItem.id!);
                                ref
                                    .refresh(productControllerProvider)
                                    .getCartProductCount();
                                setState(() {});
                                if (cartItem.quantity == 1) {
                                  cartSubtotal = cartSubtotal -
                                      (1) * double.parse(cartItem.price!);
                                  cartTotal = cartSubtotal;
                                  setState(() {
                                    isEmpty = true;
                                  });
                                } else {
                                  cartSubtotal = cartSubtotal -
                                      (1) * double.parse(cartItem.price!);
                                }
                                cartTotal = cartSubtotal;
                              },
                              icon: SvgPicture.asset(
                                  ImageConstants.arrowDown.toSvg),
                            ),
                            Padding(
                              padding: context.paddingHorizontalLow,
                              child: Text(
                                cartItem.quantity.toString(),
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await ref
                                    .refresh(cartControllerProvider)
                                    .increaseProductQuantity(cartItem.id!);
                                ref
                                    .refresh(productControllerProvider)
                                    .getCartProductCount();

                                cartSubtotal = cartSubtotal +
                                    (1) * double.parse(cartItem.price!);
                                cartTotal = cartSubtotal;
                                setState(() {});
                              },
                              icon: SvgPicture.asset(
                                  ImageConstants.arrowUp.toSvg),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () async {
                            await ref
                                .refresh(cartControllerProvider)
                                .deleteProductFromCart(cartItem.id!);
                            final count = ref
                                .refresh(productControllerProvider)
                                .getCartProductCount();
                            cartSubtotal = cartSubtotal -
                                ((cartItem.quantity!) *
                                    double.parse(cartItem.price!));
                            cartTotal = cartSubtotal;
                            setState(() {});

                            if (count == 0) {
                              setState(() {
                                isEmpty = true;
                              });
                            }
                          },
                          icon: SvgPicture.asset(
                            ImageConstants.delete.toSvg,
                            height: context.dynamicHeight(0.031),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
