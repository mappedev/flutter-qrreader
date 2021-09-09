import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:qr_reader/models/scan_model.dart';

const SCAN_HTTP_TYPE = 'http';

launchUrl(BuildContext context, ScanModel scan) async {
  if (scan.type != SCAN_HTTP_TYPE) {
    Navigator.pushNamed(context, 'map', arguments: scan);
    return;
  }
  
  final String url = scan.value;

  if (!(await canLaunch(url))) throw 'No se puede ir a la dirección $url';

  return await launch(url);
}
