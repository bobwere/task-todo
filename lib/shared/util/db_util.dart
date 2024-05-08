import 'package:quickeydb/quickeydb.dart';
import 'package:todo_app/infrastructure/schemas/user_schema.dart';

Future<QuickeyDBImpl> initializeDB() async {
  final db = await QuickeyDB.initialize(
    persist: true,
    dbVersion: 1,
    dataAccessObjects: [
      UserTaskSchema(),
    ],
    dbName: 'todo',
  );

  return db;
}
