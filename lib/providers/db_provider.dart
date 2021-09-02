import 'dart:io' show Directory;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:path/path.dart' show join;

class DBProvider {
  static final _dbName = 'ScansDB.db';
  static final _dbVersion = 1;

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

    return await openDatabase(
      path,
      // Se recomienda indicar versión para que cuando la versión aumente se vuelva ejecutar el onCreate (creación)
      version: _dbVersion, 
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }
}
