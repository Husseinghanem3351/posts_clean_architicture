import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.hint,
      required this.controller,
      this.maxLines,
      this.minLines,
      required this.validateText,
      required this.onChanged});

  final String hint;
  final TextEditingController controller;
  final int? maxLines;
  final int? minLines;
  final String validateText;
  final void Function(String) onChanged;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        validator: (value) {
          if (value!.isEmpty) {
            return widget.validateText;
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: widget.hint,
        ),
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        onChanged: (String value) {
          widget.onChanged(value);
        },
      ),
    );
  }
}
