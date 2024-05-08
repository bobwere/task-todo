import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quickeydb/quickeydb.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/enums/enums.dart';
import 'package:todo_app/domain/interfaces/task_interface.dart';
import 'package:todo_app/infrastructure/schemas/user_schema.dart';
import 'package:todo_app/shared/failure/failure.dart';

@Injectable(as: TaskFacade)
class TaskRepository implements TaskFacade {
  const TaskRepository({
    required this.db,
  });

  final QuickeyDBImpl db;

  @override
  Future<Either<Failure, Unit>> addTask(UserTask task) async {
    try {
      await db<UserTaskSchema>()!.create(task);

      return right(unit);
    } catch (e) {
      return left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(UserTask task) async {
    try {
      await db<UserTaskSchema>()!.delete(task);

      return right(unit);
    } catch (e) {
      return left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> editTask(UserTask task) async {
    try {
      await db<UserTaskSchema>()!.update(task);

      return right(unit);
    } catch (e) {
      return left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserTask>>> fetchAllTasks() async {
    try {
      final allTasks = await db<UserTaskSchema>()!.all;

      List<UserTask> updatedTasks = [];

      for (var task in allTasks) {
        if (task == null) {
          continue;
        }

        updatedTasks.add(task);
      }

      return right(updatedTasks);
    } catch (e) {
      return left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserTask>>> fetchAllPinnedTasks() async {
    try {
      final tasks = await db<UserTaskSchema>()!
          .where({'pinned': 'true', 'status != ?': 'completed'}).toList();

      final List<UserTask> updatedTasks = [];

      for (final task in tasks) {
        if (task != null) {
          updatedTasks.add(task);
        }
      }

      return right(updatedTasks);
    } catch (e) {
      return left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, UserTask>> fetchTaskById(int id) async {
    try {
      final task = await db<UserTaskSchema>()!.findBy({'id': id});

      if (task == null) {
        return left(NotFoundFailure('task not found'));
      }

      return right(task);
    } catch (e) {
      return left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTaskStatus(
      int id, TaskStatus status) async {
    try {
      final result = await fetchTaskById(id);

      return result.fold((failure) => left(failure), (task) async {
        task.status = status.name;

        final editResult = await editTask(task);

        return editResult.fold((failure) => left(failure), (r) => right(unit));
      });
    } catch (e) {
      return left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserTask>>> fetchAllTaskSortByFilterBy(
      SortTaskBy sortTaskBy, String filterBy) async {
    try {
      String orderBy = '';
      String orderOption = '';

      switch (sortTaskBy) {
        case SortTaskBy.highestPriority:
          orderBy = 'priority';
          orderOption = 'DESC';
          break;
        case SortTaskBy.leastPriority:
          orderBy = 'priority';
          orderOption = 'ASC';
          break;
        case SortTaskBy.leastRecentCreationDate:
          orderBy = 'createAt';
          orderOption = 'ASC';
          break;
        case SortTaskBy.mostRecentCreationDate:
          orderBy = 'createAt';
          orderOption = 'DESC';
          break;
        default:
      }

      final tasks = await db<UserTaskSchema>()!
          .where({'status != ?': 'completed'})
          .where(filterBy == 'All'
              ? {'pinned': 'false'}
              : {'pinned': 'false', 'category': filterBy})
          .order([orderBy], orderOption)
          .toList();

      final List<UserTask> updatedTasks = [];

      for (final task in tasks) {
        if (task != null) {
          updatedTasks.add(task);
        }
      }

      return right(updatedTasks);
    } catch (e) {
      return left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserTask>>> fetchAllTaskCompleted() async {
    try {
      final tasks = await db<UserTaskSchema>()!
          .where({'status == ?': 'completed'}).toList();

      final List<UserTask> updatedTasks = [];

      for (final task in tasks) {
        if (task != null) {
          updatedTasks.add(task);
        }
      }

      return right(updatedTasks);
    } catch (e) {
      return left(DBFailure());
    }
  }
}
