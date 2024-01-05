import 'package:posts_clean_architecture/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/global/errors/failure.dart';

class UpdatePostUseCase{
late final  PostsRepositories repositories;

UpdatePostUseCase(this.repositories);

Future<Either<Failure,Unit>> call(post) async{
  return await repositories.updatePost(post);
}
}