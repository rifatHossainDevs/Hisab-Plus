import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hisab_plus/app/auth_controller.dart';
import 'package:hisab_plus/features/customer/presentation/screens/customer_list_screen.dart';

import '../../../shared/presentation/widgets/logo.dart';
import '../../../shared/presentation/widgets/screen_background.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (await AuthController.isLoggedIn()) {
      AuthController.getUserData();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        CustomerListScreen.name,
        (predicate) => false,
      );
    } else {
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.name,
        (predicate) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Logo(),
                  const SizedBox(height: 16),
                  Text(
                    "Hisab Plus",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Simple ledger for your business",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CircularProgressIndicator(color: Colors.white),
                ],
              ),
            ),
          ),
          Text(
            "Version 1.0.0",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
