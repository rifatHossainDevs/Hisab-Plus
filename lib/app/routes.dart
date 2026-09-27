import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/customer/data/models/customer_model.dart';
import '../features/customer/presentation/screens/customer_details_screen.dart';
import '../features/customer/presentation/screens/customer_list_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Widget widget = SizedBox();

    switch (settings.name) {
      case SplashScreen.name:
        widget = SplashScreen();
        break;
      case LoginScreen.name:
        widget = LoginScreen();
        break;
      case CustomerListScreen.name:
        widget = CustomerListScreen();
        break;
      case CustomerDetailsScreen.name:
        final customer = settings.arguments as CustomerModel;
        widget = CustomerDetailsScreen(customerModel: customer,);
        break;
    }
    return MaterialPageRoute(builder: (context) => widget);
  }
}
