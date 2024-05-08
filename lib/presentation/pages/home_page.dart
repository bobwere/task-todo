import 'package:activity/activity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/task_controller.dart';
import 'package:todo_app/presentation/router/routes.dart';
import 'package:todo_app/presentation/widgets/app_button.dart';
import 'package:todo_app/presentation/widgets/app_dropdown.dart';
import 'package:todo_app/presentation/widgets/dropdowns/filterby_dropdown_button.dart';
import 'package:todo_app/presentation/widgets/dropdowns/filterby_dropdown_menu.dart';
import 'package:todo_app/presentation/widgets/dropdowns/sortby_dropdown_button.dart';
import 'package:todo_app/presentation/widgets/dropdowns/sortby_dropdown_menu.dart';
import 'package:todo_app/presentation/widgets/task_tile.dart';
import 'package:todo_app/shared/constant/app_assets.dart';
import 'package:todo_app/shared/util/enum_util.dart';
import 'package:todo_app/shared/util/text_util.dart';
import 'package:todo_app/shared/util/ui_util.dart';

class HomePage extends ActiveView<TaskController> {
  const HomePage({super.key, required super.activeController});

  @override
  ActiveState<ActiveView<ActiveController>, TaskController> createActivity() =>
      _HomePageState(activeController);
}

class _HomePageState extends ActiveState<HomePage, TaskController> {
  _HomePageState(super.activeController);

  @override
  void initState() {
    activeController.getAllTasks();
    activeController.fetchAllPinnedTasks((p0) => null);
    activeController.fetchAllUnPinnedTasks((p0) => null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ui = UiUtil(context);
    activeController.unPinnedTasks.value.length;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Tasks'),
          centerTitle: true,
        ),
        body: activeController.isFetchingUnpinnedTasks.value
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // pinned task
                        if (activeController.pinnedTasks.value.isNotEmpty) ...{
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(ui.scaleWidthFactor(16)),
                              child: Text(
                                'Pinned Tasks',
                                style: ui.textStyle.headlineSmall(),
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                activeController.pinnedTasks.value.length,
                            itemBuilder: (context, index) {
                              final activeTask =
                                  activeController.pinnedTasks.value[index];
                              final task = activeTask.value;

                              return TaskTile(task: task, route: 'home');
                            },
                          ),
                        },

                        // unpinned task
                        if (activeController.allTasks.value.isNotEmpty ||
                            activeController
                                .unPinnedTasks.value.isNotEmpty) ...{
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(ui.scaleWidthFactor(16)),
                              child: Text(
                                'Tasks',
                                style: ui.textStyle.headlineSmall(),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppDropdown(
                                dropdownButtonWidget: SortbyDropdownButton(
                                  value: uiSortBy(
                                      activeController.sortTaskBy.value),
                                  errorMsg: null,
                                ),
                                menuWidget: SortbyDropdownMenu(
                                  controller:
                                      activeController.sortByDropdownController,
                                  onItemPressed: (value) {
                                    activeController.changeSortBy(
                                        value, (p0) => null);
                                    setState(() {});
                                  },
                                ),
                                controller:
                                    activeController.sortByDropdownController,
                                link: activeController.sortByDropdownLink,
                                onPressed: () {
                                  setState(() {});
                                },
                              ),
                              AppDropdown(
                                dropdownButtonWidget: FilterbyDropdownButton(
                                  value: activeController.filterBy.value,
                                  errorMsg: null,
                                ),
                                menuWidget: FilterbyDropdownMenu(
                                  controller: activeController
                                      .filterByDropdownController,
                                  onItemPressed: (value) {
                                    activeController.changeFilterBy(
                                        value, (p0) => null);
                                    setState(() {});
                                  },
                                ),
                                controller:
                                    activeController.filterByDropdownController,
                                link: activeController.filterByDropdownLink,
                                onPressed: () {
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                activeController.unPinnedTasks.value.length,
                            itemBuilder: (context, index) {
                              final activeTask =
                                  activeController.unPinnedTasks.value[index];
                              final task = activeTask.value;

                              return TaskTile(task: task, route: 'home');
                            },
                          ),
                        },

                        // If no task is found in the db show zero state
                        if (activeController.allTasks.value.isEmpty &&
                            activeController.pinnedTasks.isEmpty) ...{
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: ui.scaleHeightFactor(50)),
                              child: Column(
                                children: [
                                  Image.asset(
                                    emptyBoxPng,
                                    width: ui.width / 2,
                                    height: ui.width / 2,
                                  ),
                                  spacerVertical(ui.scaleHeightFactor(20)),
                                  Text(
                                    'No Task Yet!',
                                    style: ui.textStyle.titleMedium(),
                                  ),
                                  spacerVertical(ui.scaleHeightFactor(8)),
                                  Text(
                                    'You have no pending task, create one now!',
                                    style: ui.textStyle.bodySmall(),
                                  ),
                                  spacerVertical(ui.scaleHeightFactor(20)),
                                  AppButton.primary(
                                    label: 'Create a task',
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ui.scaleWidthFactor(80)),
                                    fullWidth: true,
                                    isLoading:
                                        activeController.isAddingATask.value,
                                    onPressed: () {
                                      context.goNamed(
                                        addEditTodoRoute,
                                        pathParameters: {
                                          'operation': 'add',
                                          'id': '0'
                                        },
                                      );
                                    },
                                  ),
                                  spacerVertical(ui.scaleHeightFactor(20)),
                                ],
                              ),
                            ),
                          )
                        },

                        // If no task is found in the db show zero state
                        if (activeController.allTasks.value.isNotEmpty &&
                            activeController.unPinnedTasks.value.isEmpty) ...{
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: ui.scaleHeightFactor(50)),
                              child: Column(
                                children: [
                                  Image.asset(
                                    emptyBoxPng,
                                    width: ui.width / 2,
                                    height: ui.width / 2,
                                  ),
                                  spacerVertical(ui.scaleHeightFactor(20)),
                                  Text(
                                    'No Task Found!',
                                    style: ui.textStyle.titleMedium(),
                                  ),
                                  spacerVertical(ui.scaleHeightFactor(8)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ui.scaleWidthFactor(70)),
                                    child: Text(
                                      'Change category in the filter or create a new task under this category',
                                      style: ui.textStyle.bodySmall(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  spacerVertical(ui.scaleHeightFactor(20)),
                                  AppButton.primary(
                                    label: 'Create a task',
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ui.scaleWidthFactor(80)),
                                    fullWidth: true,
                                    isLoading:
                                        activeController.isAddingATask.value,
                                    onPressed: () {
                                      context.goNamed(
                                        addEditTodoRoute,
                                        pathParameters: {
                                          'operation': 'add',
                                          'id': '0'
                                        },
                                      );
                                    },
                                  ),
                                  spacerVertical(ui.scaleHeightFactor(20)),
                                ],
                              ),
                            ),
                          )
                        }
                      ],
                    ),
                    // if (activeController.sortByDropdownController.isShowing)
                    //   Opacity(
                    //     opacity: 0,
                    //     child: ModalBarrier(
                    //       color: ui.colors.primary,
                    //       onDismiss: () {
                    //         activeController.sortByDropdownController.hide();
                    //         setState(() {});
                    //       },
                    //     ),
                    //   ),
                    // if (activeController.filterByDropdownController.isShowing)
                    //   Opacity(
                    //     opacity: 0,
                    //     child: ModalBarrier(
                    //       color: ui.colors.primary,
                    //       onDismiss: () {
                    //         activeController.filterByDropdownController.hide();
                    //         setState(() {});
                    //       },
                    //     ),
                    //   ),
                  ],
                ),
              ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 120),
          child: FloatingActionButton(
            backgroundColor: ui.colors.primary,
            child: Icon(
              Icons.add,
              color: ui.colors.background,
            ),
            onPressed: () {
              context.goNamed(
                addEditTodoRoute,
                pathParameters: {'operation': 'add', 'id': '0'},
              );
            },
          ),
        ),
      ),
    );
  }
}
