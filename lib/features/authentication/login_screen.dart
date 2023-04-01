import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/utils.dart';
import 'package:tiktok_clone/generated/l10n.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  // safeArea

  void _onSingUpTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: ((context) => const LoginFormScreen()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                S.of(context).loginTitle('TecHigh'),
                style: const TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Gaps.v20,
              const Text(
                'Create a profile, follow other accounts, make your own videos, and more.',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.black45,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              GestureDetector(
                onTap: () => _onEmailTap(context),
                child: const AuthButton(
                  text: "Use email & password",
                  icon: FaIcon(
                    FontAwesomeIcons.user,
                  ),
                ),
              ),
              Gaps.v16,
              const AuthButton(
                text: "Continue with Apple",
                icon: FaIcon(FontAwesomeIcons.apple),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          color: isDarkMode(context) ? null : Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.only(
              top: Sizes.size32,
              bottom: Sizes.size64,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onSingUpTap(context),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
