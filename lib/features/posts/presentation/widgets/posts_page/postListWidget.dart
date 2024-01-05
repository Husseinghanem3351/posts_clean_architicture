import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/detailsPage.dart';

import '../../../domain/entities/post.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostListWidget({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(
            posts[index].id.toString(),
          ),
          title: Text(
            posts[index].title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            posts[index].body,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,

          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailPage(post: posts[index]),
                ));
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
        );
      },
      itemCount: posts.length,
    );
  }
}
