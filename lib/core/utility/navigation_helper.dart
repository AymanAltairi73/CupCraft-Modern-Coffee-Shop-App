import 'package:flutter/material.dart';
import '../../data/model/Coffee.dart';
import '../../Presentation/pages/home_screen.dart';
import '../../Presentation/pages/cart_screen.dart';
import '../../Presentation/pages/favorite_screen.dart';
import '../../Presentation/pages/profile_screen.dart';
import '../../Presentation/pages/NotificationScreen.dart';
import '../../Presentation/pages/checkout_screen.dart';
import 'coffee_page_transitions.dart';

class NavigationHelper {
  static void navigateToPage(
    BuildContext context,
    int index, {
    List<Coffee>? coffeeList,
    Function(Coffee)? onFavoriteChanged,
    Function(Coffee, {bool? isSelected, int? quantity})? onCartChanged,
    bool replace = true,
  }) {
    Widget destinationPage;
    TransitionType transitionType;

    switch (index) {
      case 0:
        destinationPage = const HomeScreen();
        transitionType = TransitionType.fade;
        break;
      case 1:
        destinationPage = CartScreen(
          coffeeList: coffeeList ?? [],
          onCartChanged: onCartChanged ?? ((_, {isSelected, quantity}) {}),
        );
        transitionType = TransitionType.smooth;
        break;
      case 2:
        destinationPage = FavoriteScreen(
          coffeeList: coffeeList ?? [],
          onFavoriteChanged: onFavoriteChanged ?? ((_) {}),
        );
        transitionType = TransitionType.gentle;
        break;
      case 3:
        destinationPage = const ProfileScreen();
        transitionType = TransitionType.fade;
        break;
      default:
        destinationPage = const HomeScreen();
        transitionType = TransitionType.fade;
    }

    if (replace) {
      Navigator.pushReplacement(
        context,
        _getTransition(destinationPage, transitionType),
      );
    } else {
      Navigator.push(
        context,
        _getTransition(destinationPage, transitionType),
      );
    }
  }

  static PageRouteBuilder _getTransition(Widget page, TransitionType type) {
    switch (type) {
      case TransitionType.fade:
        return CoffeePageTransitions.fadeSlideTransition(page: page);
      case TransitionType.smooth:
        return CoffeePageTransitions.smoothFadeTransition(page: page);
      case TransitionType.gentle:
        return CoffeePageTransitions.gentleSlideTransition(page: page);
    }
  }

  static void goBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      navigateToPage(context, 0);
    }
  }

  static void goToNotifications(BuildContext context) {
    Navigator.push(
      context,
      CoffeePageTransitions.fadeSlideTransition(
        page: const NotificationScreen(),
      ),
    );
  }

  static void goToCheckout(
    BuildContext context, {
    required List<Coffee> coffeeList,
    required Function(Coffee, {bool? isSelected, int? quantity}) onCartChanged,
  }) {
    Navigator.push(
      context,
      CoffeePageTransitions.smoothFadeTransition(
        page: CheckoutScreen(
          coffeeList: coffeeList,
          onCartChanged: onCartChanged,
        ),
      ),
    );
  }
}