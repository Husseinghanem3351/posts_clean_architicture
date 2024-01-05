import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/Edit_Posts/edit_posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/edit_posts_page/text_form_feild.dart';

import '../../../domain/entities/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  FormWidget({super.key, required this.isUpdatePost, required this.post});

  final bool isUpdatePost;
  final Post? post;
  bool isTheButtonValidate = false;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
              controller: titleController,
              validateText: 'the title should be not empty',
              hint: 'title',
              onChanged: (String value) {
                setState(() {
                  if (value.isEmpty) {
                    widget.isTheButtonValidate = false;
                  } else {
                    if (bodyController.text.isNotEmpty) {
                      widget.isTheButtonValidate = true;
                    }
                  }
                });
              },
            ),
            TextFormFieldWidget(
              controller: bodyController,
              validateText: 'the body should be not empty',
              hint: 'Body',
              minLines: 6,
              maxLines: 6,
              onChanged: (String value) {
                setState(() {
                  if (value.isEmpty) {
                    widget.isTheButtonValidate = false;
                  } else {
                    if (titleController.text.isNotEmpty) {
                      widget.isTheButtonValidate = true;
                    }
                  }
                });
              },
            ),
            elevatedButton()
          ],
        ));
  }

  Widget elevatedButton() {
    return ElevatedButton.icon(
      style: widget.isTheButtonValidate
          ? null
          : const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.grey)),
      onPressed: () {
        validateThenUpdateAndAddPost();
      },
      icon: widget.isUpdatePost
          ? const Icon(
              Icons.edit,
              color: Colors.white,
            )
          : const Icon(
              Icons.add,
              color: Colors.white,
            ),
      label: Text(
        widget.isUpdatePost ? 'update' : 'add',
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(color: Colors.white),
      ),
    );
  }

  void validateThenUpdateAndAddPost() {
    if (widget.isTheButtonValidate) {
      if (formKey.currentState!.validate()) {
        final post = Post(
            id: widget.isUpdatePost ? widget.post!.id : null,
            title: titleController.text,
            body: bodyController.text);
        if (widget.isUpdatePost) {
          BlocProvider.of<EditPostsBloc>(context)
              .add(UpdatePostEvent(post: post));
        } else {
          BlocProvider.of<EditPostsBloc>(context).add(AddPostEvent(post: post));
        }
      }
    }
  }
}
