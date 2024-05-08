import 'package:activity/activity.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/application/task_controller.dart';
import 'package:todo_app/presentation/widgets/task_tile.dart';
import 'package:todo_app/shared/constant/app_assets.dart';
import 'package:todo_app/shared/util/text_util.dart';
import 'package:todo_app/shared/util/ui_util.dart';

class CompletedTodosPage extends ActiveView<TaskController> {
  const CompletedTodosPage({super.key, required super.activeController});

  @override
  ActiveState<ActiveView<ActiveController>, TaskController> createActivity() =>
      _CompletedTodosPageState(activeController);
}

class _CompletedTodosPageState
    extends ActiveState<CompletedTodosPage, TaskController> {
  _CompletedTodosPageState(super.activeController);

  @override
  void initState() {
    activeController.getAllCompletedTasks(() {}, (p0) => null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ui = UiUtil(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
        centerTitle: true,
      ),
      body: activeController.isFetchingCompletedTasks.value
          ? const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                // completed task
                if (activeController.completedTasks.value.isNotEmpty) ...{
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: activeController.completedTasks.value.length,
                    itemBuilder: (context, index) {
                      final activeTask =
                          activeController.completedTasks.value[index];
                      final task = activeTask.value;

                      return TaskTile(
                        task: task,
                        route: 'completed',
                      );
                    },
                  ),
                },

                // no completed task
                if (activeController.completedTasks.value.isEmpty) ...{
                  // Center
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: ui.scaleHeightFactor(50)),
                      child: Column(
                        children: [
                          Image.asset(
                            emptyBoxPng,
                            width: ui.width / 2,
                            height: ui.width / 2,
                          ),
                          spacerVertical(ui.scaleHeightFactor(20)),
                          Text(
                            'No Task Completed Yet!',
                            style: ui.textStyle.titleMedium(),
                          ),
                          spacerVertical(ui.scaleHeightFactor(8)),
                          Text(
                            'Completed task will appear here.',
                            style: ui.textStyle.bodySmall(),
                          ),
                          spacerVertical(ui.scaleHeightFactor(20)),
                        ],
                      ),
                    ),
                  )
                }
              ],
            ),
    );
  }
}
