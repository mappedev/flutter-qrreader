import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/widgets/custom_navigation_bar.dart';
import 'package:qr_reader/widgets/scan_button.dart';
import 'package:qr_reader/widgets/scans_tiles.dart';

import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
                  .removeAllScans();
            },
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

    final scanListProvider =
        Provider.of<ScanListProvider>(context);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return ScanTiles(scans: scanListProvider.scans);
      case 1:
        scanListProvider.loadScansByType('http');
        return ScanTiles(scans: scanListProvider.scans);
      default:
        return ScanTiles();
    }
  }
}
