import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';

import '../../../config/items/colors.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({
    super.key,
    required this.cartSubtotal,
    required this.cartTotal,
  });

  final double cartSubtotal;
  final double cartTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Subtotal",
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: context.dynamicWidth(0.035),
                color: AppColors.titleBlack,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "\$ ${cartSubtotal.toString()}",
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: context.dynamicWidth(0.035),
                color: AppColors.titleBlack,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: context.dynamicWidth(0.035),
                color: AppColors.titleBlack,
              ),
            ),
            Text(
              "\$ ${cartTotal.toString()}",
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: context.dynamicWidth(0.035),
                color: AppColors.titleBlack,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
