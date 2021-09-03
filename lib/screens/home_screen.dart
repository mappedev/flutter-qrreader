import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/screens/directions_fragment.dart';
import 'package:qr_reader/screens/maps_fragment.dart';
import 'package:qr_reader/widgets/custom_navigation_bar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/models/scan_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavigationBar(),
      body: _HomePageBody(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final int currentIndex = uiProvider.selectedMenuOpt;

    // TODO: Temporal leer DB
    final tempScan = ScanModel(value: 'https://mappedev.vercel.app/');
    DBProvider.db.getScansByType('http').then((scans) => print('SCANS TYPE HTTP::: ${scans.isNotEmpty ? scans : 'No hay'}'));
    DBProvider.db.getScansByType('geo').then((scans) => print('SCANS TYPE GEO::: ${scans.isNotEmpty ? scans : 'No hay'}'));

    switch(currentIndex) {
      case 0:
        return MapsFragment();
      case 1:
        return DirectionsFragment();
      default:
        return MapsFragment();
    }
  }
}
