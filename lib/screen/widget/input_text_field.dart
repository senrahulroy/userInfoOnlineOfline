import 'package:flutter/material.dart';

import 'title_text.dart';

class TitleTextFormField extends StatelessWidget {
  const TitleTextFormField({
    super.key,
    required this.title,
    this.titleHint = '',
    this.controller,
    this.expands = false,
    this.maxLines = 1,
    this.validator,
    this.keyboardType
  });
  final String title;
  final String titleHint;
  final TextEditingController? controller;
  final bool expands;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(title: title),
        TextFormField(
          keyboardType: keyboardType,
          maxLines: maxLines,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),

              ///
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),

              ///
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),

              ///
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: titleHint),
          expands: expands,
        ),
      ],
    );
  }
}
