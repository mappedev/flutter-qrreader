//import 'dart:convert';

//ScanModel scanModelFromJson(String str) => ScanModel.fromMap(json.decode(str));
//String scanModelToJson(ScanModel data) => json.encode(data.toMap());

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
  ScanModel({
    this.id,
    this.type,
    required this.value,
  }) {
    this.type = this.value.contains('http') ? 'http' : 'geo';
  }

  int? id;
  String? type;
  String value;

  factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json['id'],
        type: json['tipo'],
        value: json['valor'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'tipo': type,
        'valor': value,
      };

  LatLng getLatLng() {
    final List<String> latLng = value.substring(4).split(',');
    final double lat = double.parse(latLng[0]);
    final double lng = double.parse(latLng[1]);

    return LatLng(lat, lng);
  }
}

