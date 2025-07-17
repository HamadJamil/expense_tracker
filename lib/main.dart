import 'package:expense_tracker/home_screen.dart';
import 'package:expense_tracker/local/provider/splash_provider.dart';
import 'package:expense_tracker/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashProvider(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            home:
                context.watch<SplashProvider>().isNew
                    ? HomeScreen()
                    : SplashScreen(),
          );
        }
      ),
    );
  }
}
