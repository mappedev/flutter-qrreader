import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/providers/providers.dart';

import 'package:qr_reader/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color themePrimaryColor = Colors.teal;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        routes: {
          'home': (_) => HomeScreen(),
          'map': (_) => MapScreen(),
        },
        initialRoute: 'home',
        theme: ThemeData(
          primaryColor: themePrimaryColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: themePrimaryColor,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: themePrimaryColor,
          ),
        ),
      ),
    );
  }
}
