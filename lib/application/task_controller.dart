import 'package:activity/activity.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/application/main_controller.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/enums/enums.dart';
import 'package:todo_app/domain/interfaces/task_interface.dart';
import 'package:todo_app/shared/failure/failure.dart';
import 'package:todo_app/shared/util/enum_util.dart';
import 'package:todo_app/shared/util/validation_util.dart';

@singleton
class TaskController extends MainController {
  // member varaibles
  final TaskFacade taskFacade;
  // constructor
  TaskController(this.taskFacade);

  // state
  ActiveBool isFetchingPinnedTasks = ActiveBool(false);
  ActiveList<ActiveModel<UserTask>> pinnedTasks = ActiveList([]);

  ActiveBool isFetchingCompletedTasks = ActiveBool(false);
  ActiveList<ActiveModel<UserTask>> completedTasks = ActiveList([]);

  ActiveBool isFetchingUnpinnedTasks = ActiveBool(false);
  ActiveList<ActiveModel<UserTask>> unPinnedTasks = ActiveList([]);

  ActiveList<ActiveModel<UserTask>> allTasks = ActiveList([]);

  ActiveBool isAddingATask = ActiveBool(false);
  ActiveBool isUpdatingATask = ActiveBool(false);
  ActiveBool isDeletingATask = ActiveBool(false);

  ActiveString sortTaskBy =
      ActiveString(SortTaskBy.mostRecentCreationDate.name);
  OverlayPortalController sortByDropdownController = OverlayPortalController();
  LayerLink sortByDropdownLink = LayerLink();

  ActiveString filterBy = ActiveString('All');
  OverlayPortalController filterByDropdownController =
      OverlayPortalController();
  LayerLink filterByDropdownLink = LayerLink();

  TextEditingController titleController = TextEditingController();

  TextEditingController statusController = TextEditingController();
  OverlayPortalController statusDropdownController = OverlayPortalController();
  LayerLink statusDropdownLink = LayerLink();

  TextEditingController pinnedStatusController =
      TextEditingController(text: 'false');
  OverlayPortalController pinnedStatusDropdownController =
      OverlayPortalController();
  LayerLink pinnedStatusDropdownLink = LayerLink();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController categoryController = TextEditingController();
  OverlayPortalController categoryDropdownController =
      OverlayPortalController();
  LayerLink categoryDropdownLink = LayerLink();

  TextEditingController priorityController = TextEditingController();
  OverlayPortalController priorityDropdownController =
      OverlayPortalController();
  LayerLink priorityDropdownLink = LayerLink();

  void resetFormValues() {
    titleController.clear();
    statusController.clear();
    pinnedStatusController.text = 'false';
    descriptionController.clear();
    categoryController.clear();
    priorityController.clear();
  }

  void setTaskToEdit(UserTask task) {
    titleController.text = task.title;
    statusController.text = task.status;
    pinnedStatusController.text = task.pinned;
    descriptionController.text = task.description;
    categoryController.text = task.category ?? 'Personal';
    priorityController.text = task.priority.toString();
  }

  Future<void> updatedEditedTask(UserTask task, VoidCallback onSuccess,
      Function(Failure) onFailure) async {
    final updatedTask = UserTask(
      id: task.id,
      title: titleController.text,
      status: statusController.text,
      description: descriptionController.text,
      pinned: pinnedStatusController.text,
      category: categoryController.text,
      priority: int.parse(priorityController.text),
      createAt: task.createAt,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    final isValid = FormValidator.isAddTaskFormValid(
      title: titleController.text,
      description: descriptionController.text,
      pinned: pinnedStatusController.text,
      category: categoryController.text,
      priority: priorityController.text,
    );

    if (!isValid) {
      onFailure(IncompleteFormFailure('Form is incomplete'));
      return;
    }

    await updateTask(updatedTask, onSuccess, onFailure);
  }

  Future<void> changeSortBy(String sortBy, Function(Failure) onFailure) async {
    final sortByvalue = sortByFromString(sortBy).name;
    sortTaskBy.set(sortByvalue);
    fetchAllUnPinnedTasks(onFailure);
  }

  Future<void> changeFilterBy(
      String filterByString, Function(Failure) onFailure) async {
    filterBy.set(filterByString);
    fetchAllUnPinnedTasks(onFailure);
  }

  // methods to manipulate state
  // fetch all pinned tasks
  Future<void> fetchAllPinnedTasks(Function(Failure) onFailure) async {
    isFetchingPinnedTasks.set(true);
    final result = await taskFacade.fetchAllPinnedTasks();

    result.fold((failure) {
      onFailure(failure);
      isFetchingPinnedTasks.set(false);
    }, (tasks) {
      isFetchingPinnedTasks.set(false);
      pinnedTasks.set(tasks.map((task) => ActiveModel(task)).toList());
    });
  }

  // fetch all unpinned tasks
  Future<void> fetchAllUnPinnedTasks(Function(Failure) onFailure) async {
    isFetchingUnpinnedTasks.set(true);
    final result = await taskFacade.fetchAllTaskSortByFilterBy(
      sortByFromString(sortTaskBy.value),
      filterBy.value,
    );

    result.fold((failure) {
      onFailure(failure);
      isFetchingUnpinnedTasks.set(false);
    }, (tasks) {
      unPinnedTasks.set(tasks.map((task) => ActiveModel(task)).toList());
      isFetchingUnpinnedTasks.set(false);
    });
  }

  // add tasks
  Future<void> addTask(
      VoidCallback onSuccess, Function(Failure) onFailure) async {
    if (isAddingATask.isTrue) {
      return;
    }

    isAddingATask.set(true);

    final isValid = FormValidator.isAddTaskFormValid(
      title: titleController.text,
      description: descriptionController.text,
      pinned: pinnedStatusController.text,
      category: categoryController.text,
      priority: priorityController.text,
    );

    if (!isValid) {
      isAddingATask.set(false);
      onFailure(IncompleteFormFailure('Form is incomplete'));
      return;
    }

    final result = await taskFacade.addTask(
      UserTask(
        title: titleController.text,
        status: 'pending',
        pinned: pinnedStatusController.text,
        description: descriptionController.text,
        category: categoryController.text,
        priority: int.tryParse(priorityController.text) ?? 1,
        createAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    result.fold((failure) {
      onFailure(failure);
      isAddingATask.set(false);
    }, (unit) async {
      await fetchAllUnPinnedTasks(onFailure);
      await fetchAllPinnedTasks(onFailure);
      await getAllTasks();
      isAddingATask.set(false);
      onSuccess();
    });
  }

  // update tasks
  Future<void> updateTask(UserTask task, VoidCallback onSuccess,
      Function(Failure) onFailure) async {
    if (isUpdatingATask.isTrue) {
      return;
    }

    isUpdatingATask.set(true);
    final result = await taskFacade.editTask(task);

    result.fold((failure) {
      onFailure(failure);
      isUpdatingATask.set(false);
    }, (unit) async {
      await fetchAllPinnedTasks(onFailure);
      await fetchAllUnPinnedTasks(onFailure);
      await getAllTasks();
      if (task.status == 'completed') {
        await getAllCompletedTasks(onSuccess, onFailure);
      }
      isUpdatingATask.set(false);
      onSuccess();
    });
  }

  // delete tasks
  Future<void> deleteTask(UserTask task, VoidCallback onSuccess,
      Function(Failure) onFailure) async {
    if (isDeletingATask.isTrue) {
      return;
    }

    isDeletingATask.set(true);
    final result = await taskFacade.deleteTask(task);

    result.fold((failure) {
      isDeletingATask.set(false);
      onFailure(failure);
    }, (unit) async {
      await fetchAllPinnedTasks(onFailure);
      await fetchAllUnPinnedTasks(onFailure);
      await getAllTasks();
      isDeletingATask.set(false);
      onSuccess();
    });
  }

  // get all tasks
  Future<void> getAllTasks() async {
    final result = await taskFacade.fetchAllTasks();

    result.fold((failure) => null, (tasks) async {
      allTasks.set(tasks.map((task) => ActiveModel(task)).toList());
    });
  }

  // get all completed Tasks
  Future<void> getAllCompletedTasks(
      VoidCallback onSuccess, Function(Failure) onFailure) async {
    isFetchingCompletedTasks.set(true);

    final result = await taskFacade.fetchAllTaskCompleted();

    result.fold((failure) {
      isFetchingCompletedTasks.set(false);
      onFailure(failure);
    }, (tasks) {
      completedTasks.set(tasks.map((task) => ActiveModel(task)).toList());
      isFetchingCompletedTasks.set(false);
      onSuccess();
    });
  }

  @override
  Iterable<ActiveType> get activities => [
        isFetchingPinnedTasks,
        isFetchingCompletedTasks,
        isFetchingUnpinnedTasks,
        isAddingATask,
        isUpdatingATask,
        isDeletingATask,
        pinnedTasks,
        completedTasks,
        unPinnedTasks,
        allTasks,
        sortTaskBy,
        filterBy
      ];
}
