import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:post_app/Feature/data/repositories/post_repository_imp.dart';
import 'package:post_app/Feature/presentation/bloc/add_update_delete_post_bloc/add_update_delete_post_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Feature/data/data_sources/local/post_local_datasources.dart';
import 'Feature/data/data_sources/remote/post_remot_datasources.dart';
import 'Feature/domain/repositories/post_repository.dart';
import 'Feature/domain/use_cases/create_post.dart';
import 'Feature/domain/use_cases/delet_post.dart';
import 'Feature/domain/use_cases/get_post.dart';
import 'Feature/domain/use_cases/update_post.dart';
import 'Feature/presentation/bloc/posts_bloc/post_bloc.dart';
import 'core/network_info/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Bloc

  sl.registerFactory(() => PostBloc(
        getAllPosts: sl(),
      ));

  sl.registerFactory(() => AddUpdateDeletePostBloc(
      addPost: sl(), deletePost: sl(), updatePost: sl()));

// Use Cases

  sl.registerLazySingleton(() => GetAllPosts(sl()));

  sl.registerLazySingleton(() => CreatePost(sl()));

  sl.registerLazySingleton(() => DeletePost(sl()));

  sl.registerLazySingleton(() => UpdatePost(sl()));

// Repository

  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      localDataSources: sl(), remoteDataSources: sl(), networkInfo: sl()));

// Data Sources

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<LocalDataSources>(
      () => LocalDataSourcesImpl(sharedPrefrences: sl()));

  sl.registerLazySingleton<RemoteDataSources>(() => RemoteDataSourcesImpl(client: sl()));

// Core

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

// External
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker()
  
  );
}
