import 'package:flutter/material.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({Key? key, required this.icon, required this.onPressed})
      : super(key: key);
  final Icon icon;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.grey.withOpacity(0.5),
      child: icon,
      onPressed: onPressed,
    );
  }
}
