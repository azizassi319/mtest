import 'package:flutter/material.dart';

class MySnackbar extends StatelessWidget {
  final String title;
  final Color color;
  const MySnackbar({
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          border: Border.all(color: color, width: 3)),
      padding: const EdgeInsets.all(8),
      height: 50,
      child: Text(title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium),
    );
  }
}
