import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/features/posts/domain/repositories/posts_repositories.dart';

import '../../../../global/errors/failure.dart';

class DeletePostUseCase {
late final PostsRepositories repositories;
DeletePostUseCase(this.repositories);

Future<Either<Failure,Unit>> call (int postId)async{
   return await repositories.deletePost(postId);
}

}