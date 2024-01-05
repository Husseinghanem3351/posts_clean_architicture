import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/Edit_Posts/edit_posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/PostsPage.dart';
import 'package:posts_clean_architecture/global/util/snackBar.dart';
import 'package:posts_clean_architecture/global/widgets/LoadingWidget.dart';

import '../../../domain/entities/post.dart';
import '../../pages/add_update_post_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DeleteDialogWidget.dart';
import 'deleteButton.dart';

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
          post.title,
          style: Theme.of(context).textTheme.titleMedium,
        )),
        const Divider(
          height: 50,
        ),
        Text(
          post.body,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DeleteUpdateButton(
              post: post,
              text: 'Edit',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PostAddUpdatePage(isUpdate: true, post: post),
                    ));
              },
            ),
            DeleteUpdateButton(
              backgroundColor: const MaterialStatePropertyAll(Colors.redAccent),
              post: post,
              text: 'Delete',
              onPressed: () {
                deleteDialog(context);
              },
            )
          ],
        ),
      ],
    );
  }

  void deleteDialog(context) {
    showDialog(
      context: context,
      builder: (context) => BlocConsumer<EditPostsBloc, EditPostsState>(
        builder: (context, state) {
          if (state is EditPostLoadingState) {
            return const AlertDialog(
              title: LoadingWidget(),
            );
          }
          return DeleteDialogWidget(postId: post.id!);
        },
        listener: (context, state) {
          if (state is MessageEditPostsState) {
            SnackBarMessage().showSnackBar(state.message, context, 'Success');
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return PostsPage();
              },
            ), (route) => false);
          } else if (state is EditPostErrorState) {
            Navigator.of(context).pop(context);
            SnackBarMessage().showSnackBar(state.message, context, 'Error');
          }
        },
      ),
    );
  }
}
