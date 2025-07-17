import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/local/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashProvider>().initializePreference();
    context.read<SplashProvider>().checkPreference();
    Future.delayed(const Duration(milliseconds: 7650), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Be', style: GoogleFonts.arOneSans(fontSize: 43.0)),
            SizedBox(
              width: 230,
              child: DefaultTextStyle(
                style: GoogleFonts.anton(fontSize: 40.0),
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  repeatForever: false,
                  animatedTexts: [
                    RotateAnimatedText(
                      'ORGANISED',
                      textStyle: GoogleFonts.anton(fontSize: 40),
                    ),
                    RotateAnimatedText(
                      'SECURE',
                      textStyle: GoogleFonts.anton(fontSize: 40),
                    ),
                    RotateAnimatedText(
                      'INSIGHTFUL',
                      textStyle: GoogleFonts.anton(fontSize: 40),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
