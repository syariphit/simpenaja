import 'package:eminovel/helpers/constants.dart';
import 'package:eminovel/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: rei_primaryColor,
        accentColor: rei_primaryColor,
        buttonColor: rei_primaryColor,
        indicatorColor: rei_primaryColor,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: rei_primaryColor.withOpacity(.5),
          cursorColor: rei_primaryColor.withOpacity(.6),
          selectionHandleColor: rei_primaryColor.withOpacity(1),
        ),
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SplashScreen(),
    );
  }
}