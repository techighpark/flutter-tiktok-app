import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TikTokApp());
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.dark,
  // );
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'TikTok Clone',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.ptSansTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade500,
        ),
        // highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
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
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.ptSansTextTheme(
          ThemeData(
            brightness: Brightness.dark,
          ).textTheme,
        ),
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.deepOrange,
        ),
        primaryColor: Colors.deepOrange[600],
      ),
      home: const SignUpScreen(),
    );
  }
}
