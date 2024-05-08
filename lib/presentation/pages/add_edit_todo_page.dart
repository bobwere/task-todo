import 'package:activity/activity.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/task_controller.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/router/routes.dart';
import 'package:todo_app/presentation/widgets/app_button.dart';
import 'package:todo_app/presentation/widgets/app_dropdown.dart';
import 'package:todo_app/presentation/widgets/app_input.dart';
import 'package:todo_app/presentation/widgets/dropdowns/category_dropdown_button.dart';
import 'package:todo_app/presentation/widgets/dropdowns/category_dropdown_menu.dart';
import 'package:todo_app/presentation/widgets/dropdowns/pinned_status_dropdown_button.dart';
import 'package:todo_app/presentation/widgets/dropdowns/pinned_status_dropdown_menu.dart';
import 'package:todo_app/presentation/widgets/dropdowns/priority_status_dropdown_button.dart';
import 'package:todo_app/presentation/widgets/dropdowns/priority_status_dropdown_menu.dart';
import 'package:todo_app/presentation/widgets/keyboard_dimiss.dart';
import 'package:todo_app/shared/constant/app_strings.dart';
import 'package:todo_app/shared/util/ui_util.dart';
import 'package:todo_app/shared/util/validation_util.dart';

class AddEditTodosPage extends ActiveView<TaskController> {
  const AddEditTodosPage({
    super.key,
    required super.activeController,
    required this.id,
    required this.operation,
  });

  final String operation;
  final int id;

  @override
  ActiveState<ActiveView<ActiveController>, TaskController> createActivity() =>
      _AddEditTodosPageState(activeController);
}

class _AddEditTodosPageState
    extends ActiveState<AddEditTodosPage, TaskController> {
  _AddEditTodosPageState(super.activeController);

  bool canValidateFields = false;
  UserTask? taskToModify;

  @override
  void initState() {
    if (widget.id != 0) {
      final tasks = activeController.allTasks.value
          .where((active) => active.value.id == widget.id);

      if (tasks.length == 1) {
        taskToModify = tasks.first.value;
      }
    }

    if (widget.operation == 'add') {
      activeController.resetFormValues();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ui = UiUtil(context);
    return KeyboardDismiss(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.operation == 'add' ? 'Add Task' : ' Edit Task'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: ui.colors.primary,
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // title
                  AppInput(
                    textEditingController: activeController.titleController,
                    label: title,
                    hint: hintTitle,
                    maxLength: 50,
                    onChanged: (value) {
                      setState(() {});
                    },
                    error: canValidateFields
                        ? FormValidator.validateTitle(
                            activeController.titleController.text)
                        : null,
                  ),
                  SizedBox(
                    height: ui.scaleHeightFactor(32),
                  ),

                  // description
                  AppInput(
                    textEditingController:
                        activeController.descriptionController,
                    maxLength: 240,
                    maxLines: 5,
                    label: description,
                    hint: hintDescription,
                    onChanged: (value) {
                      setState(() {});
                    },
                    error: canValidateFields
                        ? FormValidator.validateDescription(
                            activeController.descriptionController.text)
                        : null,
                  ),
                  SizedBox(
                    height: ui.scaleHeightFactor(32),
                  ),

                  // priority
                  AppDropdown(
                    dropdownButtonWidget: PriorityStatusDropdownButton(
                      value: activeController.priorityController.text,
                      errorMsg: canValidateFields
                          ? FormValidator.validatePriority(
                              activeController.priorityController.text)
                          : null,
                    ),
                    menuWidget: PriorityStatusDropdownMenu(
                      controller: activeController.priorityDropdownController,
                      onItemPressed: (value) {
                        activeController.priorityController.text = value;
                        setState(() {});
                      },
                    ),
                    controller: activeController.priorityDropdownController,
                    link: activeController.priorityDropdownLink,
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: ui.scaleHeightFactor(32),
                  ),

                  // category
                  AppDropdown(
                    dropdownButtonWidget: CategoryDropdownButton(
                      value: activeController.categoryController.text,
                      errorMsg: canValidateFields
                          ? FormValidator.validateCategory(
                              activeController.categoryController.text)
                          : null,
                    ),
                    menuWidget: CategoryDropdownMenu(
                      controller: activeController.categoryDropdownController,
                      onItemPressed: (value) {
                        activeController.categoryController.text = value;

                        setState(() {});
                      },
                    ),
                    controller: activeController.categoryDropdownController,
                    link: activeController.categoryDropdownLink,
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: ui.scaleHeightFactor(32),
                  ),

                  // pinned
                  AppDropdown(
                    dropdownButtonWidget: PinnedStatusDropdownButton(
                      value:
                          activeController.pinnedStatusController.text == 'true'
                              ? 'Yes'
                              : 'No',
                      errorMsg: canValidateFields
                          ? FormValidator.validatePinned(
                              activeController.pinnedStatusController.text)
                          : null,
                    ),
                    menuWidget: PinnedStatusDropdownMenu(
                      controller:
                          activeController.pinnedStatusDropdownController,
                      onItemPressed: (value) {
                        if (value == 'Yes') {
                          activeController.pinnedStatusController.text = 'true';
                        }

                        if (value == 'No') {
                          activeController.pinnedStatusController.text =
                              'false';
                        }

                        setState(() {});
                      },
                    ),
                    controller: activeController.pinnedStatusDropdownController,
                    link: activeController.pinnedStatusDropdownLink,
                    onPressed: () {
                      setState(() {});
                    },
                  ),

                  SizedBox(
                    height: ui.scaleHeightFactor(32),
                  ),

                  AppButton.primary(
                    label: widget.operation == 'add' ? 'Add' : 'Save',
                    isLoading: activeController.isAddingATask.value ||
                        activeController.isUpdatingATask.value,
                    onPressed: () {
                      setState(() {
                        canValidateFields = true;
                      });

                      if (widget.operation == 'add') {
                        activeController.addTask(() {
                          context.pop();
                        }, (p0) {
                          Flushbar(
                            title: 'Error occurred',
                            message: p0.message ?? '',
                            backgroundColor: ui.colors.error,
                            duration: const Duration(seconds: 3),
                          ).show(context);
                        });
                      }

                      if (widget.operation == 'edit' && taskToModify != null) {
                        activeController.updatedEditedTask(taskToModify!, () {
                          context.goNamed(homeRoute);
                        }, (p0) {
                          Flushbar(
                            title: 'Error occurred',
                            message: p0.message ?? '',
                            backgroundColor: ui.colors.error,
                            duration: const Duration(seconds: 3),
                          ).show(context);
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: ui.scaleHeightFactor(32),
                  ),
                ],
              ),
            ),
            if (activeController.priorityDropdownController.isShowing)
              Opacity(
                opacity: 0,
                child: ModalBarrier(
                  color: ui.colors.primary,
                  onDismiss: () {
                    activeController.priorityDropdownController.hide();
                    setState(() {});
                  },
                ),
              ),
            if (activeController.pinnedStatusDropdownController.isShowing)
              Opacity(
                opacity: 0,
                child: ModalBarrier(
                  color: ui.colors.primary,
                  onDismiss: () {
                    activeController.pinnedStatusDropdownController.hide();
                    setState(() {});
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
