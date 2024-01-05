part of 'edit_posts_bloc.dart';

@immutable
abstract class EditPostsState extends Equatable {
  const EditPostsState();

  @override
  List<Object?> get props => [];
}

class EditPostsInitial extends EditPostsState {}

class EditPostLoadingState extends EditPostsState {}

class EditPostErrorState extends EditPostsState {
  final String message;

  const EditPostErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class MessageEditPostsState extends EditPostsState {
  final String message;

  const MessageEditPostsState({required this.message});

  @override
  List<Object?> get props => [message];
}
