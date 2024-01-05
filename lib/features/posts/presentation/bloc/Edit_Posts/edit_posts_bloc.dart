import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_architecture/features/posts/domain/use_cases/deletePost.dart';
import 'package:dartz/dartz.dart';
import '../../../../../global/errors/failure.dart';
import '../../../../../global/strings/failures.dart';
import '../../../../../global/strings/messages.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/use_cases/addPost.dart';
import '../../../domain/use_cases/updatePost.dart';

part 'edit_posts_event.dart';

part 'edit_posts_state.dart';

class EditPostsBloc extends Bloc<EditPostsEvent, EditPostsState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;

  EditPostsBloc(
      {required this.updatePost,
      required this.deletePost,
      required this.addPost})
      : super(EditPostsInitial()) {
    on<EditPostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(EditPostLoadingState());
        final failureOrAdd = await addPost(event.post);
        emit (failureOrSuccess(failureOrAdd,message: addSuccessMessage));
      }
      else if (event is DeletePostEvent) {
        emit(EditPostLoadingState());
        final failureOrDelete = await deletePost(event.id);
         emit(failureOrSuccess(failureOrDelete,message: deleteSuccessMessage));
      }
      else if (event is UpdatePostEvent) {
        emit(EditPostLoadingState());
        final failureOrUpdate = await updatePost.call(event.post);
        emit(failureOrSuccess(failureOrUpdate,message: updateSuccessMessage));
      }
    });
  }

 EditPostsState failureOrSuccess(Either<Failure, Unit> either,{required String message}) {
    return either.fold(
        (failure) => EditPostErrorState(message: mapFailureToMessage(failure)),
        (_) => MessageEditPostsState(message: message));
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return serverFailure;
      case OfflineFailure _:
        return noInternetFailure;
      default:
        return "UnexpectedError , please try again later";
    }
  }
}
