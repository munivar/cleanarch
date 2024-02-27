import 'package:flutter/material.dart';

class AppErrorText extends StatelessWidget {
  final String text;
  final int? maxLines;
  const AppErrorText(this.text, {super.key, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 2,
      style: const TextStyle(
        color: Colors.redAccent,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
