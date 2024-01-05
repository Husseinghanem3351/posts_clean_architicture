import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/Edit_Posts/edit_posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/PostsPage.dart';
import 'package:posts_clean_architecture/global/util/snackBar.dart';
import 'package:posts_clean_architecture/global/widgets/LoadingWidget.dart';

import '../../domain/entities/post.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/edit_posts_page/formWidget.dart';

class PostAddUpdatePage extends StatelessWidget {
  const PostAddUpdatePage({super.key, this.post, required this.isUpdate});

  final Post? post;
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body:  buildBody(),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: Text(
          isUpdate ? 'Edit Post' : 'Add Post',
        ),
      );

  Widget buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<EditPostsBloc, EditPostsState>(
          builder: (BuildContext context, EditPostsState state) {
            if (state is EditPostLoadingState) {
              return const LoadingWidget();
            }
            return FormWidget(
                isUpdatePost: isUpdate, post: isUpdate ? post! : null
            );
          },
          listener: (BuildContext context, EditPostsState state) {
            if (state is MessageEditPostsState) {
              SnackBarMessage().showSnackBar(state.message, context, 'Success');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostsPage(),
                  ),
                  (route) => false);
            }

            else if(state is EditPostErrorState){
              SnackBarMessage().showSnackBar(state.message, context, 'Error');
            }
          },
        ),
      ),
    );
  }
}
