import 'package:posts_clean_architecture/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/global/errors/failure.dart';

class AddPostUseCase{
  late final  PostsRepositories repositories;

  AddPostUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<Either<Failure,Unit>> call(post) async{
    return await repositories.addPost(post);
  }
}