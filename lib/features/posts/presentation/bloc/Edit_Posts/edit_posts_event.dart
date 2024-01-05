part of 'edit_posts_bloc.dart';

@immutable
abstract class EditPostsEvent extends Equatable {
  const EditPostsEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends EditPostsEvent {
  final Post post;

  const AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends EditPostsEvent {
  final Post post;

  const UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends EditPostsEvent {
  final int id;

  const DeletePostEvent({required this.id});

  @override
  List<Object> get props => [id];
}
