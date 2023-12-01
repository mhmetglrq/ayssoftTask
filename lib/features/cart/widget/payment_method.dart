import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';

import '../../../config/items/colors.dart';
import '../../../config/utility/enum/image_enum.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingVerticalLow,
      child: Row(
        children: [
          Container(
            width: context.dynamicWidth(0.13),
            padding: context.paddingAllLow,
            child: Image.asset(
              ImageConstants.visa.toPng,
            ),
          ),
          Expanded(
            child: Padding(
              padding: context.paddingHorizontalLow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Visa Classic",
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: context.dynamicWidth(0.04),
                      color: AppColors.titleBlack,
                    ),
                  ),
                  Text(
                    "**** 7690",
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: context.dynamicWidth(0.036),
                      color: AppColors.titleBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: AppColors.success,
            radius: context.dynamicWidth(0.04),
            child: const Icon(
              Icons.done,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
