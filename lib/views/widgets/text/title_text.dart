import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key,required this.Title});

  final String Title;

  @override
  Widget build(BuildContext context) {
    return Text(
      Title,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
