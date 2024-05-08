import 'package:quickeydb/quickeydb.dart';
import 'package:todo_app/domain/entities/task.dart';

class UserTaskSchema extends DataAccessObject<UserTask> {
  UserTaskSchema()
      : super(
          '''
          CREATE TABLE tasks (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            status TEXT NOT NULL,
            category TEXT NOT NULL,
            priority INTEGER NOT NULL,
            pinned TEXT NOT NULL,
            createAt INTEGER NOT NULL,
            updatedAt INTEGER NOT NULL
          )
          ''',
          converter: Converter(
            encode: (task) => UserTask.fromMap(task),
            decode: (task) => task!.toMap(),
            decodeTable: (task) => task!.toTableMap(),
          ),
        );
}
