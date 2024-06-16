import 'package:flutter/material.dart';
import 'package:maidstest/const/Tcolor.dart';

class TextFieldBilder extends StatelessWidget {
  final String Title;
  final void Function(String) onchange;
  final bool obscureText;

  const TextFieldBilder(
      {required this.Title, required this.onchange, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      textAlign: TextAlign.center,
      onChanged: onchange,
      decoration: InputDecoration(
        hintText: Title,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Tcolor.maincolor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Tcolor.maincolor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
