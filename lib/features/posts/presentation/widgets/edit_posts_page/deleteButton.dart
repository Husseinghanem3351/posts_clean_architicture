import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';
import '../../pages/add_update_post_page.dart';

class DeleteUpdateButton extends StatelessWidget {
  const DeleteUpdateButton({super.key, required this.post, required this.text, this.onPressed, this.backgroundColor});
  final Post post;
  final String text;
  final void Function()? onPressed;
  final MaterialStateProperty<Color?>? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.edit),
      label:  Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white),
      ),
      style:  ButtonStyle(
        iconColor: const MaterialStatePropertyAll(Colors.white),
        backgroundColor: backgroundColor
      ),
    );
  }
}
