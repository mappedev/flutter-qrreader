import 'package:flutter/material.dart';

import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/models/scan_model.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String typeSelected = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = new ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);
    // Asignar el ID de la DB al modelo
    newScan.id = id;

    if (typeSelected == newScan.type) {
      scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  void loadScans() async {
    final allScans = await DBProvider.db.getAllScans();
    scans = [...allScans];
    notifyListeners();
  }

  void loadScansByType(String type) async {
    final scansByType = await DBProvider.db.getScansByType(type);
    scans = [...scansByType];
    typeSelected = type;
    notifyListeners();
  }

  void removeAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  void removeScan(int id) async {
    scans.removeWhere((scan) => scan.id == id);
    notifyListeners();

    await DBProvider.db.deleteScan(id);
  }
}
