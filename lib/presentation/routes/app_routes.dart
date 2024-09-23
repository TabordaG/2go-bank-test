import 'package:flutter/material.dart';
import 'package:test_2go_bank/presentation/screens/checkout_screen.dart';

import 'name_routes.dart';

class AppRoutes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.checkout: (context) => const CheckoutScreen(),
  };
}
