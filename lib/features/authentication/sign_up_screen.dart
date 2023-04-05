import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends StatelessWidget {
  static const routeUrl = "/";
  static const routeName = "signup";
  const SignUpScreen({super.key});
  void _onLoginTap(BuildContext context) async {
    context.push(LoginScreen.routeName);
    // context.push(LoginScreen.routeName);
    //
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const LoginScreen(),
    //   ),
    // );
    //
    // await Navigator.of(context).pushNamed(LoginScreen.routeName);
    // await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const LoginScreen(),
    //   ),
    // );
    print("User came back!");
  }

  void _onEmailTap(BuildContext context) {
    context.pushNamed(UsernameScreen.routeName);
    // context.push(UsernameScreen.routeName);
    //
    // Navigator.of(context).pushNamed(UsernameScreen.routeName);
    //
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     // transitionDuration: const Duration(seconds: 5),
    //     pageBuilder: (
    //       context,
    //       animation,
    //       secondaryAnimation,
    //     ) {
    //       return const UsernameScreen();
    //     },
    //     transitionsBuilder: (
    //       context,
    //       animation,
    //       secondaryAnimation,
    //       child,
    //     ) {
    //       // child = pageBuilder가 return 하는 것
    //       final offsetAnimation = Tween(
    //         begin: const Offset(0, -1),
    //         end: const Offset(0, 0),
    //       ).animate(animation);
    //       final opacityAnimation = Tween(
    //         begin: 0.3,
    //         end: 0.7,
    //       ).animate(animation);
    //       return SlideTransition(
    //         position: offsetAnimation,
    //         child: FadeTransition(
    //           opacity: opacityAnimation,
    //           child: child,
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    print(Localizations.localeOf(context));

    return OrientationBuilder(
      builder: (context, orientation) {
        /* if (orientation == Orientation.landscape) {
          return const Scaffold(
            body: Center(
              child: Text('Plz rotate ur phone.'),
            ),
          );
        } */
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gaps.v80,
                  Text(
                    S.of(context).signUpTitle(
                          'TecHigh',
                          DateTime.now(),
                        ),
                    style: const TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).signUpSubtitle(1),
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    GestureDetector(
                      onTap: () => _onEmailTap(context),
                      child: AuthButton(
                        icon: const FaIcon(FontAwesomeIcons.user),
                        text: S.of(context).emailPasswordButton,
                      ),
                    ),
                    Gaps.v16,
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.apple),
                      text: S.of(context).appleButton,
                    )
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onEmailTap(context),
                            child: AuthButton(
                              icon: const FaIcon(FontAwesomeIcons.user),
                              text: S.of(context).emailPasswordButton,
                            ),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.apple),
                            text: S.of(context).appleButton,
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: isDarkMode(context) ? null : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: Sizes.size32, bottom: Sizes.size64),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).alreadyHaveAnAccount,
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      S.of(context).logIn('female'),
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
