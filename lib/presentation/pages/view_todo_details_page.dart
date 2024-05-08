// ignore_for_file: depend_on_referenced_packages

import 'package:activity/activity.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/task_controller.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/router/routes.dart';
import 'package:todo_app/presentation/widgets/app_button.dart';
import 'package:todo_app/shared/util/enum_util.dart';
import 'package:todo_app/shared/util/text_util.dart';
import 'package:todo_app/shared/util/ui_util.dart';
import 'package:intl/intl.dart';

class ViewTodoDetailPage extends ActiveView<TaskController> {
  const ViewTodoDetailPage(
      {super.key, required super.activeController, required this.id});

  final int id;

  @override
  ActiveState<ActiveView<ActiveController>, TaskController> createActivity() =>
      _ViewTodoDetailPageState(activeController);
}

class _ViewTodoDetailPageState
    extends ActiveState<ViewTodoDetailPage, TaskController> {
  _ViewTodoDetailPageState(super.activeController);

  UserTask? task;

  @override
  void initState() {
    final tasks = activeController.allTasks.value
        .where((active) => active.value.id == widget.id);

    if (tasks.length == 1) {
      task = tasks.first.value;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ui = UiUtil(context);

    String date = '';

    if (task != null) {
      date = DateFormat('yyyy-MM-dd hh:mm')
          .format(DateTime.fromMillisecondsSinceEpoch(task!.createAt));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ui.colors.primary,
          ),
        ),
      ),
      body: task == null
          ? const SizedBox()
          : Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      task?.title ?? '',
                      style: ui.textStyle.titleMedium(),
                    ),
                  ),
                ),
                spacerVertical(ui.scaleHeightFactor(16)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      'Description',
                      style: ui.textStyle.titleSmall(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      task?.description ?? '',
                      style: ui.textStyle
                          .bodyMedium()
                          .copyWith(color: ui.colors.activeColor),
                    ),
                  ),
                ),
                spacerVertical(ui.scaleHeightFactor(16)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      'Status',
                      style: ui.textStyle.titleSmall(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      task?.status ?? '',
                      style: ui.textStyle
                          .bodyMedium()
                          .copyWith(color: ui.colors.activeColor),
                    ),
                  ),
                ),
                spacerVertical(ui.scaleHeightFactor(16)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      'Creation Date',
                      style: ui.textStyle.titleSmall(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      date,
                      style: ui.textStyle
                          .bodyMedium()
                          .copyWith(color: ui.colors.activeColor),
                    ),
                  ),
                ),
                spacerVertical(ui.scaleHeightFactor(16)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      'Priority',
                      style: ui.textStyle.titleSmall(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      intToPriority(task?.priority ?? 1),
                      style: ui.textStyle
                          .bodyMedium()
                          .copyWith(color: ui.colors.activeColor),
                    ),
                  ),
                ),
                spacerVertical(ui.scaleHeightFactor(16)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      'Category',
                      style: ui.textStyle.titleSmall(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      task?.category ?? '',
                      style: ui.textStyle
                          .bodyMedium()
                          .copyWith(color: ui.colors.activeColor),
                    ),
                  ),
                ),
                spacerVertical(ui.scaleHeightFactor(16)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      'Pinned',
                      style: ui.textStyle.titleSmall(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ui.scaleWidthFactor(16)),
                    child: Text(
                      task?.pinned == 'true' ? 'Yes' : 'No',
                      style: ui.textStyle
                          .bodyMedium()
                          .copyWith(color: ui.colors.activeColor),
                    ),
                  ),
                ),
                const Spacer(),
                if (task?.status != 'completed')
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await activeController.deleteTask(
                            task!,
                            () {
                              context.pop();
                            },
                            (p0) => Flushbar(
                              title: 'Error occurred',
                              message: p0.message ?? '',
                              backgroundColor: ui.colors.error,
                              duration: const Duration(seconds: 3),
                            ).show(context),
                          );
                        },
                        icon: activeController.isDeletingATask.value
                            ? const SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(),
                              )
                            : Icon(
                                Icons.delete_outlined,
                                color: ui.colors.primary,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          //
                          activeController.setTaskToEdit(task!);
                          //
                          context.goNamed(
                            editTodoRoute,
                            pathParameters: {
                              'operation': 'edit',
                              'id': (task?.id ?? 0).toString(),
                              'edit_id': (task?.id ?? 0).toString()
                            },
                          );
                        },
                        icon: Icon(
                          Icons.edit_outlined,
                          color: ui.colors.primary,
                        ),
                      ),
                      const Spacer(),
                      activeController.isUpdatingATask.value
                          ? const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                  bottom: ui.scaleHeightFactor(16)),
                              child: AppButton.primary(
                                label: 'Mark as completed',
                                fullWidth: false,
                                isLoading: activeController.isAddingATask.value,
                                onPressed: () {
                                  final taskClone = task;
                                  taskClone?.status = 'completed';

                                  activeController.updateTask(
                                    taskClone!,
                                    () {
                                      context.pop();
                                    },
                                    (p0) => {
                                      Flushbar(
                                        title: 'Error occurred',
                                        message: p0.message ?? '',
                                        backgroundColor: ui.colors.error,
                                        duration: const Duration(seconds: 3),
                                      ).show(context),
                                    },
                                  );
                                },
                              ),
                            )
                    ],
                  )
              ],
            ),
    );
  }
}
