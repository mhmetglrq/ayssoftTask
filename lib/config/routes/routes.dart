import 'package:flutter/material.dart';
import 'package:flutter_product_app/features/home/view/home.dart';
import 'package:flutter_product_app/features/product/view/product_details.dart';

import '../../features/cart/view/cart.dart';
import '../../features/product/view/product_list.dart';
import 'route_names.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const Home());
      case RouteNames.home:
        return _materialRoute(const Home());
      case RouteNames.productList:
        return _materialRoute(const ProductList());

      case RouteNames.productDetails:
        final arguments = settings.arguments as Map<String, dynamic>;
        final productId = arguments["productId"];
        return _materialRoute(ProductDetails(productId: productId));

      case RouteNames.cart:
        return _materialRoute(const Cart());

      default:
        return _materialRoute(const Home());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
