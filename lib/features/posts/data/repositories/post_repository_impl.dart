import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architecture/features/posts/domain/repositories/posts_repositories.dart';
import 'package:posts_clean_architecture/global/errors/failure.dart';
import '../../../../global/deviceConnected/connectedDevice.dart';
import '../../../../global/errors/exception.dart';
import '../data_sources/PostLocalDataSource.dart';
import '../data_sources/PostReomteDataSource.dart';

typedef PostControl = Future<Unit> Function();

class PostsRepositoryImpl implements PostsRepositories {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final ConnectDevice isDeviceConnected;

  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.isDeviceConnected,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await isDeviceConnected.isDeviceConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePost(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.title);
    return retFun(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return retFun(() => remoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return retFun(() => remoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> retFun(PostControl function) async {
    if (await isDeviceConnected.isDeviceConnected) {
      try {
        function;
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
