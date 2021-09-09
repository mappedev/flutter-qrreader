import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/screens/home_screen.dart';
import 'package:qr_reader/screens/map_screen.dart';

import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color themePrimaryColor = Colors.teal;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
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
