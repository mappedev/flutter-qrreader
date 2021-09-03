import 'dart:io' show Directory;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:path/path.dart' show join;

import 'package:qr_reader/models/models.dart' show ScanModel;

class DBProvider {
  static final _dbName = 'ScansDB.db';
  static final _dbVersion = 1;
  static final _dbTableName = 'Scans';

  DBProvider._();

  static Database? _database;
  static final DBProvider _db = DBProvider._();

  static DBProvider get db => _db;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    // Path donde se almacenará la DB
    // PD: cuando la aplicación se borré, se borrará también el path de la DB
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _dbName);

    print('path $path');

    // Creación de la DB
    return await openDatabase(
      path,
      // Se recomienda indicar versión para que cuando la versión aumente se vuelva ejecutar el onCreate (creación)
      version: _dbVersion,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE '$_dbTableName'(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }

  // Forma larga de realizar un INSERT en una tabla
  //Future<int> newScanRaw(ScanModel newScan) async {
  //final id = newScan.id;
  //final type = newScan.type;
  //final value = newScan.value;

  //// Verificar la DB
  //final db = await database;
  //final res = await db.rawInsert('''
  //INSERT INTO Scans(id, tipo, valor)
  //VALUES($id, $type, $value)
  //''');
  //return res;
  //}

  // CREATE
  // Forma corta de realizar un INSERT en una tabla
  // También es la forma más seguro porque impide inyecciones de SQL
  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert(_dbTableName, newScan.toMap());
    print('RES::: $res');
    // 'res' es el id del último registro insertado
    return res;
  }

  // READ
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query(_dbTableName, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromMap(res.first) : null;
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    //final res = await db.query(_dbTableName, where: 'tipo = ?', whereArgs: [type]);
    final res = await db.rawQuery('''
      SELECT * FROM '$_dbTableName' WHERE tipo = '$type'
    ''');
    return res.isNotEmpty
        ? res.map((row) => ScanModel.fromMap(row)).toList()
        : [];
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query(_dbTableName);
    return res.isNotEmpty
        ? res.map((row) => ScanModel.fromMap(row)).toList()
        : [];
  }

  // UPDATE
  //Future<ScanModel> updateScanByid(int id) async {
    //final db = await database;
    //final res = await db.update(table, values)
  //}
}
