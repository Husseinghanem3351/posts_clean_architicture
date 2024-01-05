import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/PostLocalDataSource.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/PostReomteDataSource.dart';
import 'package:posts_clean_architecture/features/posts/data/repositories/post_repository_impl.dart';
import 'package:posts_clean_architecture/features/posts/domain/repositories/posts_repositories.dart';
import 'package:posts_clean_architecture/features/posts/domain/use_cases/addPost.dart';
import 'package:posts_clean_architecture/features/posts/domain/use_cases/deletePost.dart';
import 'package:posts_clean_architecture/features/posts/domain/use_cases/updatePost.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/Edit_Posts/edit_posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_clean_architecture/global/deviceConnected/connectedDevice.dart';
import 'package:posts_clean_architecture/global/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'features/posts/domain/use_cases/getAllPosts.dart';
import 'features/posts/presentation/pages/PostsPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<void> main() async {
  Bloc.observer=MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  PostsRepositories repository() => PostsRepositoryImpl(
      remoteDataSource: PostRemoteDataSourceImpl(
        client: http.Client(),
      ),
      localDataSource: PostLocalDataSourceImpl(prefs: sharedPreferences),
      isDeviceConnected:
          ConnectDeviceImpl(isConnected: InternetConnectionChecker()));

  const MyApp({
    super.key,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostsBloc(
            getAllPosts: GetAllPostsUseCase(
              repository(),
            ),
          )..add(GetAllPostsEvent()),
        ),
        BlocProvider(
          create: (context) => EditPostsBloc(
              updatePost: UpdatePostUseCase(repository()),
              deletePost: DeletePostUseCase(repository()),
              addPost: AddPostUseCase(repository()),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home:  PostsPage(),
      ),
    );
  }
}
