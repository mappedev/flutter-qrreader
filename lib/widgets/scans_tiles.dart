import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/utils/launch_url.dart';

const SCAN_HTTP_TYPE = 'http';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key, this.scans}) : super(key: key);

  final List<ScanModel>? scans;

  @override
  Widget build(BuildContext context) {
    if (scans?.length == 0)
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Escanea un código QR',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.scanner_rounded,
              size: 80,
            ),
          ],
        ),
      );

    return ListView.builder(
      itemCount: scans?.length ?? 0,
      itemBuilder: (_, i) => Dismissible(
        key: Key(scans![i].id.toString()),
        onDismissed: (_) {
          Provider.of<ScanListProvider>(context, listen: false)
              .removeScan(scans![i].id!);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Eliminado el código QR: ${scans![i].value}')));
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: Icon(
            Icons.delete,
            color: Colors.white70,
          ),
        ),
        child: ListTile(
          onTap: () => launchUrl(context, scans![i]),
          leading: Icon(
            scans![0].type == SCAN_HTTP_TYPE
                ? Icons.web_rounded
                : Icons.map_rounded,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scans![i].value),
          subtitle: Text(scans![i].id.toString()),
          trailing: Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
