import 'package:flutter/material.dart';
import 'package:flutter_product_app/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/routes/route_names.dart';
import 'config/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('cart');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: const AppTheme().themeData,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      initialRoute: RouteNames.initialRoute,
    );
  }
}
