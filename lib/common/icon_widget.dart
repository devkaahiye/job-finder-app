import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final Color color;
  final Color iconColors;
  final IconData icon;
  const IconWidget(
      {Key? key,
      required this.color,
      required this.icon,
      required this.iconColors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      child: Icon(
        icon,
        color: iconColors,
      ),
    );
  }
}
