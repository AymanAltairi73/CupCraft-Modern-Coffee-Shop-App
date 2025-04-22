import 'package:flutter/material.dart';
import '../model/Coffee.dart';

class NavigationHelper {
  static void navigateToPage(BuildContext context, int index, {
    List<Coffee>? coffeeList,
    Function(Coffee)? onFavoriteChanged,
    Function(Coffee, {bool? isSelected, int? quantity})? onCartChanged,
  }) {
    String route;
    Object? arguments;

    switch (index) {
      case 0:
        route = '/home';
        break;
      case 1:
        route = '/cart';
        arguments = {
          'coffeeList': coffeeList,
          'onCartChanged': onCartChanged,
        };
        break;
      case 2:
        route = '/favorites';
        arguments = {
          'coffeeList': coffeeList,
          'onFavoriteChanged': onFavoriteChanged,
        };
        break;
      case 3:
        route = '/profile';
        break;
      default:
        route = '/home';
    }

    Navigator.pushReplacementNamed(
      context,
      route,
      arguments: arguments,
    );
  }
}