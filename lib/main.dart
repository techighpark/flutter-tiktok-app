import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TikTok Clone',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          // highlightColor: Colors.transparent,
          // splashColor: Colors.transparent,
          primaryColor: Colors.deepOrange[600],
          // every text field property!!
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.deepOrange[600],
            // selectionColor: Colors.red,
            // [Q]
            selectionHandleColor: Colors.pink,
          ),
          // primaryColor: const Color(0xFFE9435A),
          appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              titleTextStyle: TextStyle(
                fontSize: Sizes.size16 + Sizes.size2,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
        ),
        home: const ActivityScreen());
  }
}
