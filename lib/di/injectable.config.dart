// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i37;
import 'package:drift/drift.dart' as _i6;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:icapps_architecture/icapps_architecture.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import '../db/dao/book_dao_storage.dart' as _i14;
import '../db/dao/draft_dao_storage.dart' as _i15;
import '../db/dao/history_dao_storage.dart' as _i16;
import '../db/dao/listed_dao_storage.dart' as _i17;
import '../db/dao/search_dao_storage.dart' as _i18;
import '../db/dao/song_dao_storage.dart' as _i19;
import '../db/songlib_db.dart' as _i12;
import '../repository/db_repository.dart' as _i21;
import '../repository/debug_repository.dart' as _i22;
import '../repository/locale_repository.dart' as _i24;
import '../repository/refresh_repository.dart' as _i27;
import '../repository/secure_storage/auth_storage.dart' as _i20;
import '../repository/secure_storage/secure_storage.dart' as _i10;
import '../repository/shared_prefs/local_storage.dart' as _i23;
import '../repository/web_repository.dart' as _i40;
import '../util/cache/cache_controller.dart' as _i4;
import '../util/cache/cache_controlling.dart' as _i3;
import '../util/interceptor/network_auth_interceptor.dart' as _i25;
import '../util/interceptor/network_error_interceptor.dart' as _i8;
import '../util/interceptor/network_log_interceptor.dart' as _i9;
import '../util/interceptor/network_refresh_interceptor.dart' as _i36;
import '../vm/global_vm.dart' as _i31;
import '../vm/home/home_vm.dart' as _i33;
import '../vm/lists/histories_vm.dart' as _i32;
import '../vm/lists/likes_vm.dart' as _i34;
import '../vm/lists/list_vm.dart' as _i35;
import '../vm/manage/selection_vm.dart' as _i41;
import '../vm/manage/settings_vm.dart' as _i28;
import '../vm/songs/editor_vm.dart' as _i30;
import '../vm/songs/presentor_vm.dart' as _i26;
import '../vm/splash_vm.dart' as _i29;
import '../vm/uitest_vm.dart' as _i13;
import '../webservice/api_client.dart' as _i39;
import '../webservice/web_service.dart' as _i38;
import 'injectable.dart' as _i42;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.CacheControlling>(_i4.CacheController());
  gh.singleton<_i5.ConnectivityHelper>(registerModule.connectivityHelper());
  await gh.singletonAsync<_i6.DatabaseConnection>(
      () => registerModule.provideDatabaseConnection(),
      preResolve: true);
  gh.lazySingleton<_i7.FlutterSecureStorage>(() => registerModule.storage());
  gh.singleton<_i8.NetworkErrorInterceptor>(
      _i8.NetworkErrorInterceptor(get<_i5.ConnectivityHelper>()));
  gh.singleton<_i9.NetworkLogInterceptor>(_i9.NetworkLogInterceptor());
  gh.lazySingleton<_i10.SecureStorage>(
      () => _i10.SecureStorage(get<_i7.FlutterSecureStorage>()));
  await gh.singletonAsync<_i11.SharedPreferences>(() => registerModule.prefs(),
      preResolve: true);
  gh.lazySingleton<_i12.SongLibDb>(
      () => registerModule.provideSongLibDb(get<_i6.DatabaseConnection>()));
  gh.factory<_i13.UiTestVm>(() => _i13.UiTestVm());
  gh.lazySingleton<_i14.BookDaoStorage>(
      () => _i14.BookDaoStorage(get<_i12.SongLibDb>()));
  gh.lazySingleton<_i15.DraftDaoStorage>(
      () => _i15.DraftDaoStorage(get<_i12.SongLibDb>()));
  gh.lazySingleton<_i16.HistoryDaoStorage>(
      () => _i16.HistoryDaoStorage(get<_i12.SongLibDb>()));
  gh.lazySingleton<_i17.ListedDaoStorage>(
      () => _i17.ListedDaoStorage(get<_i12.SongLibDb>()));
  gh.lazySingleton<_i18.SearchDaoStorage>(
      () => _i18.SearchDaoStorage(get<_i12.SongLibDb>()));
  gh.lazySingleton<_i5.SharedPreferenceStorage>(
      () => registerModule.sharedPreferences(get<_i11.SharedPreferences>()));
  gh.lazySingleton<_i5.SimpleKeyValueStorage>(() =>
      registerModule.keyValueStorage(
          get<_i5.SharedPreferenceStorage>(), get<_i10.SecureStorage>()));
  gh.lazySingleton<_i19.SongDaoStorage>(
      () => _i19.SongDaoStorage(get<_i12.SongLibDb>()));
  gh.lazySingleton<_i20.AuthStorage>(
      () => _i20.AuthStorage(get<_i5.SimpleKeyValueStorage>()));
  gh.lazySingleton<_i21.DbRepository>(() => _i21.DbRepository(
      get<_i14.BookDaoStorage>(),
      get<_i15.DraftDaoStorage>(),
      get<_i16.HistoryDaoStorage>(),
      get<_i17.ListedDaoStorage>(),
      get<_i18.SearchDaoStorage>(),
      get<_i19.SongDaoStorage>()));
  gh.lazySingleton<_i22.DebugRepository>(
      () => _i22.DebugRepository(get<_i5.SharedPreferenceStorage>()));
  gh.lazySingleton<_i23.LocalStorage>(() => _i23.LocalStorage(
      get<_i20.AuthStorage>(), get<_i5.SharedPreferenceStorage>()));
  gh.lazySingleton<_i24.LocaleRepository>(
      () => _i24.LocaleRepository(get<_i5.SharedPreferenceStorage>()));
  gh.singleton<_i25.NetworkAuthInterceptor>(
      _i25.NetworkAuthInterceptor(get<_i20.AuthStorage>()));
  gh.factory<_i26.PresentorVm>(() =>
      _i26.PresentorVm(get<_i21.DbRepository>(), get<_i23.LocalStorage>()));
  gh.lazySingleton<_i27.RefreshRepository>(
      () => _i27.RefreshRepository(get<_i20.AuthStorage>()));
  gh.factory<_i28.SettingsVm>(() =>
      _i28.SettingsVm(get<_i21.DbRepository>(), get<_i23.LocalStorage>()));
  gh.factory<_i29.SplashVm>(() => _i29.SplashVm(get<_i23.LocalStorage>()));
  gh.factory<_i30.EditorVm>(
      () => _i30.EditorVm(get<_i21.DbRepository>(), get<_i23.LocalStorage>()));
  gh.singleton<_i31.GlobalVm>(_i31.GlobalVm(get<_i24.LocaleRepository>(),
      get<_i22.DebugRepository>(), get<_i23.LocalStorage>()));
  gh.factory<_i32.HistoriesVm>(() =>
      _i32.HistoriesVm(get<_i21.DbRepository>(), get<_i23.LocalStorage>()));
  gh.factory<_i33.HomeVm>(
      () => _i33.HomeVm(get<_i21.DbRepository>(), get<_i23.LocalStorage>()));
  gh.factory<_i34.LikesVm>(
      () => _i34.LikesVm(get<_i21.DbRepository>(), get<_i23.LocalStorage>()));
  gh.factory<_i35.ListVm>(
      () => _i35.ListVm(get<_i21.DbRepository>(), get<_i23.LocalStorage>()));
  gh.singleton<_i36.NetworkRefreshInterceptor>(
      _i36.NetworkRefreshInterceptor(get<_i27.RefreshRepository>()));
  gh.lazySingleton<_i5.CombiningSmartInterceptor>(() =>
      registerModule.provideCombiningSmartInterceptor(
          get<_i9.NetworkLogInterceptor>(),
          get<_i25.NetworkAuthInterceptor>(),
          get<_i8.NetworkErrorInterceptor>(),
          get<_i36.NetworkRefreshInterceptor>()));
  gh.lazySingleton<_i37.Dio>(
      () => registerModule.provideDio(get<_i5.CombiningSmartInterceptor>()));
  gh.singleton<_i38.WebService>(_i39.ApiClient(get<_i37.Dio>()),
      registerFor: {_dev, _prod});
  gh.lazySingleton<_i40.WebRepository>(
      () => _i40.WebRepository(get<_i38.WebService>()));
  gh.factory<_i41.SelectionVm>(() => _i41.SelectionVm(get<_i40.WebRepository>(),
      get<_i21.DbRepository>(), get<_i23.LocalStorage>()));
  return get;
}

class _$RegisterModule extends _i42.RegisterModule {}