import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app_theme.dart';
import 'app/routes.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/customer/presentation/providers/customer_list_provider.dart';

class HisabPlusApp extends StatefulWidget {
  const HisabPlusApp({super.key});

  @override
  State<HisabPlusApp> createState() => _HisabPlusAppState();
}

class _HisabPlusAppState extends State<HisabPlusApp> {
  
  final CustomerListProvider _customerListProvider = CustomerListProvider();
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _customerListProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hisab Plus',
        home: SplashScreen(),
        initialRoute: SplashScreen.name,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.lightTheme,
      ),
    );
  }
}
