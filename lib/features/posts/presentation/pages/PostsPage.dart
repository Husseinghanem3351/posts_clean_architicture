import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/add_update_post_page.dart';
import '../../../../global/widgets/LoadingWidget.dart';
import '../bloc/posts/posts_bloc.dart';
import '../widgets/posts_page/MessageDisplayWidget.dart';
import '../widgets/posts_page/postListWidget.dart';

class PostsPage extends StatelessWidget {
  PostsPage({super.key});

  final bool isBottomSheetShown = false;
  final GlobalKey formKey = GlobalKey<FormState>();
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(),
      body: Form(key: formKey, child: buildBody()),
      floatingActionButton: buildFloatingBtn(
        context,
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: const Text("posts"),
      );

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostListWidget(posts: state.posts),
            );
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(
              message: state.message,
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshAllPostsEvent());
  }

  FloatingActionButton buildFloatingBtn(
    context,
  ) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostAddUpdatePage(isUpdate: false),
            ));
      },
      child: const Icon(Icons.add),
    );
  }
}
