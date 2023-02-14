import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbName = 'db_barbearia';
  static const _dbVersion = 1;

  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String dbPath = join(await getDatabasesPath(), _dbName);
    return await openDatabase(dbPath,
        version: _dbVersion, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute(servicos);
  }

  String servicos = '''
  CREATE TABLE servicos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome VARCHAR(255) NOT NULL, 
      data_hora DATE NOT NULL,
      tipoServicos VARCHAR(255) NOT NULL)
  ''';
}
