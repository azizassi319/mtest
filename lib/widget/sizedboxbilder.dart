import 'package:flutter/material.dart';

class sizedboxbilder extends StatelessWidget {
  double hight;
  sizedboxbilder(this.hight);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hight,
    );
  }
}
