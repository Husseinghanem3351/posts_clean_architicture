import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';

import '../widgets/edit_posts_page/postDetailWidget.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: const Text('Post Detail'),
      );

  Widget buildBody() =>  Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: PostDetailWidget(post: post,),
        ),
      );
}
