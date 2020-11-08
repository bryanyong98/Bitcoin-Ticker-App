import 'package:flutter/material.dart';
import 'price_screen.dart';
import 'market_screen.dart';
import 'analytics_screen.dart';

/// The main running engine for the app.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.blueAccent,
          scaffoldBackgroundColor: Colors.white),
      home: MarketScreen(),
    );
  }
}
