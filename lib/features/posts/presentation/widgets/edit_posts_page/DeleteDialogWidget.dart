import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/Edit_Posts/edit_posts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  const DeleteDialogWidget({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:const Text('Are You Sure'),
      actions: [
        TextButton(
            onPressed: () {
              BlocProvider.of<EditPostsBloc>(context)
                  .add(DeletePostEvent(id: postId));
            },
            child: const Text('Yes')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'))
      ],
    );
  }
}
