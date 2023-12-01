import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';

import '../../../config/items/colors.dart';

class LeftTitle extends StatelessWidget {
  const LeftTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: context.textTheme.titleLarge?.copyWith(
          fontSize: context.dynamicWidth(0.04),
          color: AppColors.titleBlack,
        ),
      ),
    );
  }
}
