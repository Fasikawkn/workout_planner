// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:workout_planner/core/theme/theme_service.dart' as _i454;
import 'package:workout_planner/core/utils/api_client.dart' as _i109;
import 'package:workout_planner/features/workout_planner/bloc/workout_bloc.dart'
    as _i1034;
import 'package:workout_planner/features/workout_planner/repository/workout_repository.dart'
    as _i1024;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i109.ApiClient>(() => _i109.ApiClient());
    gh.factory<_i454.ThemeService>(() => _i454.ThemeService());
    gh.factory<_i1024.WorkoutRepository>(
      () => _i1024.WorkoutRepositoryImpl(
        gh<_i460.SharedPreferences>(),
        gh<_i109.ApiClient>(),
      ),
    );
    gh.factory<_i1034.WorkoutBloc>(
      () => _i1034.WorkoutBloc(gh<_i1024.WorkoutRepository>()),
    );
    return this;
  }
}
