//import 'dart:convert';

//ScanModel scanModelFromJson(String str) => ScanModel.fromMap(json.decode(str));
//String scanModelToJson(ScanModel data) => json.encode(data.toMap());

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
}

