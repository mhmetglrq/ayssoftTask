import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';

import '../../../config/items/colors.dart';
import '../../../config/utility/enum/image_enum.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingVerticalLow,
      child: Row(
        children: [
          SizedBox(
            width: context.dynamicWidth(0.13),
            child: Image.asset(
              ImageConstants.map.toPng,
            ),
          ),
          Expanded(
            child: Padding(
              padding: context.paddingHorizontalLow,
              child: Text(
                "43, Electronics City Phase 1,Electronic City",
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: context.dynamicWidth(0.04),
                  color: AppColors.descriptionGrey,
                ),
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
