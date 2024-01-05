// import 'package:posts_clean_architecture/features/posts/data/data_sources/PostLocalDataSource.dart';
// import 'package:posts_clean_architecture/features/posts/data/data_sources/PostReomteDataSource.dart';
// import 'package:posts_clean_architecture/features/posts/data/repositories/post_repository_impl.dart';
// import 'package:posts_clean_architecture/features/posts/domain/repositories/posts_repositories.dart';
// import 'package:posts_clean_architecture/features/posts/domain/use_cases/addPost.dart';
// import 'package:posts_clean_architecture/features/posts/domain/use_cases/deletePost.dart';
// import 'package:posts_clean_architecture/features/posts/domain/use_cases/getAllPosts.dart';
// import 'package:posts_clean_architecture/features/posts/domain/use_cases/updatePost.dart';
// import 'package:posts_clean_architecture/features/posts/presentation/bloc/Edit_Posts/edit_posts_bloc.dart';
// import 'package:posts_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
// import 'package:posts_clean_architecture/global/deviceConnected/connectedDevice.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
//
// Future<void> init() async {
//   ///feature posts
//
//   //Bloc
//
//   sl.registerFactory(() => PostsBloc(
//         getAllPosts: sl.call(),
//       ));
//   sl.registerFactory(() => EditPostsBloc(
//         addPost: sl.call(),
//         deletePost: sl.call(),
//         updatePost: sl.call(),
//       ));
//
//   //UseCases
//
//   sl.registerLazySingleton(() => GetAllPosts(sl()));
//   sl.registerLazySingleton(() => DeletePost(sl()));
//   sl.registerLazySingleton(() => UpdatePost(sl()));
//   sl.registerLazySingleton(() => AddPost(sl()));
//
//   //Repositories
//   sl.registerLazySingleton<PostsRepositories>(() => PostsRepositoryImpl(
//       remoteDataSource: sl(),
//       localDataSource: sl(),
//       isDeviceConnected: sl(),));
//   //Data Sources
//
//   sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));
//   sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(prefs: sl()));
//   ///global
//   sl.registerLazySingleton<ConnectDevice>(() => ConnectDeviceImpl(isConnected: sl()));
//   ///External
//   final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton(() => InternetConnectionChecker());
// }
