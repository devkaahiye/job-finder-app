import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final String text;
  final String text2;
  final IconData iconData;
  final Color iconColor;
  final IconData iconData2;
  final VoidCallback onTap;
  const IconWidget(
      {super.key,
      required this.text,
      required this.text2,
      required this.iconColor,
      required this.iconData,
      required this.iconData2,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.grey.shade200,
        child: Icon(
          iconData,
          size: 20,
        ),
      ),
      title: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(text2),
      trailing: Icon(
        iconData2,
        color: iconColor,
      ),
    );
  }
}
