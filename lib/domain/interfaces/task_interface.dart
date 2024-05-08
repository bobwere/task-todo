import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/enums/enums.dart';
import 'package:todo_app/shared/failure/failure.dart';

/* Task Facade */
abstract class TaskFacade {
  /// fetch all pinned tasks
  Future<Either<Failure, List<UserTask>>> fetchAllPinnedTasks();

  /// add new task
  Future<Either<Failure, Unit>> addTask(UserTask task);

  /// edit new task
  Future<Either<Failure, Unit>> editTask(UserTask task);

  /// delete new task
  Future<Either<Failure, Unit>> deleteTask(UserTask task);

  /// update task new task
  Future<Either<Failure, Unit>> updateTaskStatus(int id, TaskStatus status);

  /// get task by id
  Future<Either<Failure, UserTask>> fetchTaskById(int id);

  /// fetch tasks sortBy & fetch tasks sortBy
  Future<Either<Failure, List<UserTask>>> fetchAllTaskSortByFilterBy(
      SortTaskBy sortTaskBy, String filterBy);

  /// fetch tasks completed
  Future<Either<Failure, List<UserTask>>> fetchAllTaskCompleted();

  /// fetch all categories
  Future<Either<Failure, List<UserTask>>> fetchAllTasks();
}
