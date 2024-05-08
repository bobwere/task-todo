import 'package:injectable/injectable.dart';
import 'package:todo_app/app/app_wrapper.dart';
import 'package:todo_app/app/bootstrap.dart';

void main() {
  bootstrap(() => const AppWrapper(), Environment.prod);
}
