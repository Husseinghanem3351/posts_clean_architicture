import 'package:posts_clean_architecture/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';
import '../../../../global/errors/failure.dart';
import '../entities/post.dart';

class GetAllPostsUseCase{
 late final PostsRepositories repositories;
 GetAllPostsUseCase(this.repositories);

  Future<Either<Failure,List<Post>>> call() async{
    return await repositories.getAllPosts();
}
}