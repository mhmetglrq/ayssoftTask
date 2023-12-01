import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';

import '../../../config/items/colors.dart';

class VioletFilledButton extends StatelessWidget {
  const VioletFilledButton({
    super.key,
    required this.onPressed,
  });
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: context.paddingAllDefault,
        width: double.infinity,
        height: context.dynamicHeight(0.06),
        decoration: BoxDecoration(
          color: AppColors.violet,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            'Add to Cart',
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.white,
              fontSize: context.dynamicWidth(0.04),
            ),
          ),
        ),
      ),
    );
  }
}
