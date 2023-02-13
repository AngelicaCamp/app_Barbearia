import 'package:app_barbearia/database/database_helper.dart';
import 'package:app_barbearia/model/servico.dart';
import 'package:sqflite/sqflite.dart';

class ServicoDbHelper {
  static final DatabaseHelper dbHelper = DatabaseHelper.instance;

  // add service
  Future<int> insertService(Servico servico) async {
    Database db = await dbHelper.database;
    return await db.insert('servicos', servico.toMap());
  }

  // remove service
  Future<int> removeService(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('servicos', where: 'id=?', whereArgs: [id]);
  }

  // update service
  Future<void> updateService(int id) async {
    Database db = await dbHelper.database;
    var services = await db.query('servicos', where: 'id=?', whereArgs: [id]);
  }

  // list services
  Future<List<Servico>> listServices() async {
    Database db = await dbHelper.database;
    var services = await db.query('servicos', where: 'servicos', orderBy: 'id');
    List<Servico> servicesList = services.isNotEmpty
        ? services.map((e) => Servico.fromMap(e)).toList()
        : [];
    return servicesList;
  }
}
