import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_architecture/global/errors/failure.dart';
import 'package:posts_clean_architecture/global/strings/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/use_cases/getAllPosts.dart';
import 'package:dartz/dartz.dart';

part 'posts_event.dart';

part 'posts_state.dart';

//Bloc is event and state, when this event happen execute this statements and
// emit this state
//cubit need just state, when we want we will execute this state
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        emit(mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        emit(mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => ErrorPostsState(message: mapFailureToMessage(failure)),
        (posts) => LoadedPostsState(posts: posts));
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return serverFailure;
      case EmptyCacheFailure _:
        return emptyCacheFailure;
      case OfflineFailure _:
        return noInternetFailure;
      default:
        return "UnexpectedError , please try again later";
    }
  }
}
