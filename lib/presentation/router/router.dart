import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/task_controller.dart';
import 'package:todo_app/injection.dart';
import 'package:todo_app/presentation/pages/add_edit_todo_page.dart';
import 'package:todo_app/presentation/pages/completed_todos_page.dart';
import 'package:todo_app/presentation/pages/home_page.dart';
import 'package:todo_app/presentation/pages/splash_page.dart';
import 'package:todo_app/presentation/pages/view_todo_details_page.dart';
import 'package:todo_app/presentation/router/home_scaffold_with_nested_nav.dart';
import 'package:todo_app/presentation/router/routes.dart';

// Root Navigator
final _rootNavigatorKey = GlobalKey<NavigatorState>();

// Shell Navigators
final _homeShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Home');
final _completedTaskShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'Completed');

GoRouter goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: initialPath,
  navigatorKey: _rootNavigatorKey,
  observers: [],
  redirect: (BuildContext context, GoRouterState state) async {
    // no need to redirect at all
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      name: initialRoute,
      path: initialPath,
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          name: state.name,
          child: const SplashPage(),
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              FadeTransition(opacity: animation, child: child),
        );
      },
    ),

    // Home stateful nested navigation
    //
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return HomeScaffoldWithNestedNavigation(
          navigationShell: navigationShell,
        );
      },
      branches: [
        // first branch (Home)
        StatefulShellBranch(
          navigatorKey: _homeShellNavigatorKey,
          initialLocation: homePath,
          observers: const [],
          routes: [
            GoRoute(
              name: homeRoute,
              path: homePath,
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                name: state.name,
                child: HomePage(activeController: getIt<TaskController>()),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) =>
                    FadeTransition(opacity: animation, child: child),
              ),
              routes: [
                GoRoute(
                  name: addEditTodoRoute,
                  path: addEditTodoPath,
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                    key: state.pageKey,
                    name: state.name,
                    child: AddEditTodosPage(
                        operation: state.pathParameters['operation'] ?? '0',
                        id: int.parse(state.pathParameters['id'] ?? '0'),
                        activeController: getIt<TaskController>()),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) =>
                        FadeTransition(opacity: animation, child: child),
                  ),
                ),
                GoRoute(
                  name: viewTodoDetailsRoute,
                  path: viewTodoDetailsPath,
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                    key: state.pageKey,
                    name: state.name,
                    child: ViewTodoDetailPage(
                        id: int.parse(state.pathParameters['id'] ?? '0'),
                        activeController: getIt<TaskController>()),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) =>
                        FadeTransition(opacity: animation, child: child),
                  ),
                  routes: [
                    GoRoute(
                      name: editTodoRoute,
                      path: editTodoPath,
                      pageBuilder: (context, state) =>
                          CustomTransitionPage<void>(
                        key: state.pageKey,
                        name: state.name,
                        child: AddEditTodosPage(
                            operation: state.pathParameters['operation'] ?? '0',
                            id: int.parse(
                                state.pathParameters['edit_id'] ?? '0'),
                            activeController: getIt<TaskController>()),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // second branch (Completed Todos)
        StatefulShellBranch(
          navigatorKey: _completedTaskShellNavigatorKey,
          initialLocation: completedTodoPath,
          observers: const [],
          routes: [
            GoRoute(
              name: completedTodoRoute,
              path: completedTodoPath,
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                name: state.name,
                child: CompletedTodosPage(
                  activeController: getIt<TaskController>(),
                ),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) =>
                    FadeTransition(opacity: animation, child: child),
              ),
              routes: [
                GoRoute(
                  name: completedViewTodoDetailsRoute,
                  path: completedViewTodoDetailsPath,
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                    key: state.pageKey,
                    name: state.name,
                    child: ViewTodoDetailPage(
                        id: int.parse(state.pathParameters['id'] ?? '0'),
                        activeController: getIt<TaskController>()),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) =>
                        FadeTransition(opacity: animation, child: child),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (BuildContext context, GoRouterState state) => const Scaffold(),
);
