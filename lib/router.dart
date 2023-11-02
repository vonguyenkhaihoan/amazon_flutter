import 'package:amazon_flutter/common/widgets/bottom_bar.dart';
import 'package:amazon_flutter/features/admin/screen/add_product_screen.dart';
import 'package:amazon_flutter/features/auth/screens/auth_screen.dart';
import 'package:amazon_flutter/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    //AUTH
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    //HOME
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    //BOTTOMBAR
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    //ADD PRODUCT
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen does not exist!"),
          ),
        ),
      );
  }
}
