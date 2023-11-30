import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/items/colors.dart';

class ShimmerGridview extends StatelessWidget {
  const ShimmerGridview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: context.dynamicWidth(0.02),
        mainAxisSpacing: context.dynamicHeight(0.02),
      ),
      itemCount: 12,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          surfaceTintColor: AppColors.white,
          elevation: 15,
          shadowColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}
