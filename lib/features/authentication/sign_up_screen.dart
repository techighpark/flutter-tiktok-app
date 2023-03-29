import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: ((context) => const LoginScreen())));

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: ((context) => const UsernameScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        // if (orientation == Orientation.landscape) {
        //   return const Scaffold(
        //     body: Center(
        //       child: Text('Please rotate your phone'),
        //     ),
        //   );
        // }
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    'Sign up for TikTok',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 1,
                    child: Text(
                      'Create a profile, follow other accounts, make your own videos, and more.',
                      style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          fontSize: Sizes.size20,
                          color: Colors.brown,
                        ),
                      ),
                      // style: TextStyle(
                      //   fontSize: Sizes.size14,
                      //   // color: isDarkMode(context)
                      //   //     ? Colors.grey.shade400
                      //   //     : Colors.black45,
                      // ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    GestureDetector(
                      onTap: () => _onEmailTap(context),
                      child: const AuthButton(
                        text: "Use email & password",
                        icon: FaIcon(FontAwesomeIcons.user),
                      ),
                    ),
                    Gaps.v16,
                    const AuthButton(
                      text: "Continue with Apple",
                      icon: FaIcon(FontAwesomeIcons.apple),
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onEmailTap(context),
                            child: const AuthButton(
                              text: "Use email & password",
                              icon: FaIcon(FontAwesomeIcons.user),
                            ),
                          ),
                        ),
                        Gaps.h16,
                        const Expanded(
                          child: AuthButton(
                            text: "Continue with Apple",
                            icon: FaIcon(FontAwesomeIcons.apple),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              // color: Theme.of(context).bottomAppBarTheme.color,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size32,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    Gaps.h5,
                    GestureDetector(
                      onTap: () => _onLoginTap(context),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
