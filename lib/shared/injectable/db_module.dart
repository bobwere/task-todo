// ignore_for_file: invalid_annotation_target

import 'package:injectable/injectable.dart';
import 'package:quickeydb/quickeydb.dart';
import 'package:todo_app/shared/util/db_util.dart';

@module
abstract class DBModule {
  @preResolve
  Future<QuickeyDBImpl> get db => initializeDB();
}
