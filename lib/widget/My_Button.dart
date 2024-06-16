import 'package:flutter/material.dart';

class My_button extends StatelessWidget {
  final Color color;
  final String title;
  final Color titleColor;
  final VoidCallback onpressed;

  const My_button(
      {required this.color,
      required this.title,
      required this.titleColor,
      required this.onpressed});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        onPressed: onpressed,
        minWidth: MediaQuery.of(context).size.width,
        height: 42,
        child: Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 20,
            fontFamily: 'H',
          ),
        ),
      ),
    );
  }
}
