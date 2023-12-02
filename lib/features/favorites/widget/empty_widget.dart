import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/extensions/context_extension.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: context.paddingVerticalDefault,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/json/heart.json",
                height: context.dynamicHeight(0.2),
              ),
              Text(
                "Favorites is empty!\n Let's add some products",
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
