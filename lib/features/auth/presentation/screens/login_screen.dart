import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hisab_plus/features/auth/data/models/login_params.dart';
import 'package:hisab_plus/features/auth/providers/login_provider.dart';
import 'package:hisab_plus/features/customer/presentation/screens/customer_list_screen.dart';
import 'package:hisab_plus/features/shared/presentation/widgets/centered_progress_indicator.dart';
import 'package:hisab_plus/features/shared/presentation/widgets/logo.dart';
import 'package:hisab_plus/features/shared/presentation/widgets/screen_background.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widgets/show_snackbar_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final LoginProvider _loginProvider = LoginProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loginProvider,
      child: ScreenBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          top: 120,
                          bottom: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Logo(),
                            const SizedBox(height: 60),
                            Text(
                              "Hisab Plus",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Sign in to manage your customer ledger.",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 32,
                            bottom: 16,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _emailTEController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "Enter your email",
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFFFAFCFB),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _clearTextFields();
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your email";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Password",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _passwordTEController,
                                  obscureText: !isPasswordVisible,
                                  obscuringCharacter: '*',
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: "Enter your password",
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFFFAFCFB),
                                    suffixIcon: IconButton(
                                      onPressed: _setVisibilityPassword,
                                      icon: Icon(
                                        isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your password";
                                    } else if (value.length < 6) {
                                      return "Password must be at least 6 characters";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 40),
                                Consumer<LoginProvider>(
                                  builder: (context, _, _) {
                                    if (_loginProvider.isLoginInProgress) {
                                      return CenteredProgressIndicator();
                                    }
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 4,
                                      ),
                                      onPressed: _onTapSignInButton,
                                      child: Text(
                                        "Sign in",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 16),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Company: ',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF6B7685),
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Dominate Software',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF12836E),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _setVisibilityPassword() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _login();
    }
  }

  Future<void> _login() async {
    LoginParams loginParams = LoginParams(
      userName: _emailTEController.text.trim(),
      password: _passwordTEController.text,
    );

    bool isSuccess = await _loginProvider.setLoginInProgress(loginParams);

    if (!mounted) return;

    if (isSuccess) {
      Navigator.pushReplacementNamed(context, CustomerListScreen.name);
    } else {
      showSnackBarMessage(context, _loginProvider.errorMessage!);
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
