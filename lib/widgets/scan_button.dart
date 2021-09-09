import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/launch_url.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        final String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3D8BEF',
          'Cancelar',
          true,
          ScanMode.QR,
        );

        if (barcodeScanRes == '-1') return;

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        final newScan = await scanListProvider.newScan(barcodeScanRes);

        launchUrl(context, newScan);
      },
      child: Icon(Icons.filter_center_focus),
    );
  }
}
