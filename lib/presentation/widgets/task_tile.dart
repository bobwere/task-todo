// ignore_for_file: depend_on_referenced_packages

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/router/routes.dart';
import 'package:todo_app/shared/util/text_util.dart';
import 'package:todo_app/shared/util/ui_util.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, required this.route});

  final UserTask task;
  final String route;

  @override
  Widget build(BuildContext context) {
    final ui = UiUtil(context);

    final date = DateFormat('yyyy-MM-dd hh:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(task.createAt));

    return GestureDetector(
      onTap: () {
        if (route == 'completed') {
          context.goNamed(
            completedViewTodoDetailsRoute,
            pathParameters: {'id': (task.id ?? '0').toString()},
          );
          return;
        }

        context.goNamed(
          viewTodoDetailsRoute,
          pathParameters: {'id': (task.id ?? '0').toString()},
        );
      },
      child: Container(
        width: ui.width,
        padding: EdgeInsets.all(ui.scaleWidthFactor(12)),
        margin: EdgeInsets.all(ui.scaleWidthFactor(12)),
        decoration: BoxDecoration(
            color: ui.colors.background,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: ui.colors.primary.withOpacity(0.05),
                  offset: const Offset(2, 2),
                  blurRadius: 8,
                  spreadRadius: 0)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          task.title,
                          style: ui.textStyle.titleMedium(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      spacerHorizontal(ui.scaleWidthFactor(5)),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: ShapeDecoration(
                          shape: const CircleBorder(),
                          color: getPriorityColor(task.priority ?? 1),
                        ),
                        child: Center(
                          child: Text(
                            (task.priority ?? 1).toString(),
                            style: ui.textStyle
                                .bodyMedium()
                                .copyWith(color: ui.colors.background),
                          ),
                        ),
                      )
                    ],
                  ),
                  spacerVertical(ui.scaleHeightFactor(8)),
                  Text(
                    task.category ?? '',
                    style: ui.textStyle
                        .bodyMedium()
                        .copyWith(color: ui.colors.subTextColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spacerVertical(ui.scaleWidthFactor(4)),
                  Text(
                    date,
                    style: ui.textStyle
                        .bodyMedium()
                        .copyWith(color: ui.colors.subTextColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: ui.scaleWidthFactor(100),
              child: Column(
                children: [
                  Text(
                    task.status,
                    style: ui.textStyle
                        .bodyMedium()
                        .copyWith(color: ui.colors.subTextColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.blueAccent;
      case 2:
        return Colors.purpleAccent;
      case 3:
        return Colors.greenAccent;
      case 4:
        return Colors.orangeAccent;
      case 5:
        return Colors.redAccent;
      default:
        return Colors.blueAccent;
    }
  }
}
