// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:jovial_svg/jovial_svg.dart' as _i5;
import 'package:quickeydb/quickeydb.dart' as _i3;

import 'application/main_controller.dart' as _i4;
import 'application/task_controller.dart' as _i8;
import 'domain/interfaces/task_interface.dart' as _i6;
import 'infrastructure/task_repository.dart' as _i7;
import 'shared/injectable/db_module.dart' as _i9;
import 'shared/injectable/utility_module.dart' as _i10;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dBModule = _$DBModule();
  final utilityModule = _$UtilityModule();
  await gh.factoryAsync<_i3.QuickeyDBImpl>(
    () => dBModule.db,
    preResolve: true,
  );
  gh.factory<_i4.MainController>(() => _i4.MainController());
  gh.lazySingleton<_i5.ScalableImageCache>(
      () => utilityModule.scalableImageCache);
  gh.factory<_i6.TaskFacade>(
      () => _i7.TaskRepository(db: gh<_i3.QuickeyDBImpl>()));
  gh.singleton<_i8.TaskController>(
      () => _i8.TaskController(gh<_i6.TaskFacade>()));
  return getIt;
}

class _$DBModule extends _i9.DBModule {}

class _$UtilityModule extends _i10.UtilityModule {}
