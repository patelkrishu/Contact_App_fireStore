import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(this.Title,{super.key, this.onPressed});

  final void Function()? onPressed;

  final String Title;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(onPressed: onPressed,color: Colors.brown,child: Text(Title),);
  }
}
