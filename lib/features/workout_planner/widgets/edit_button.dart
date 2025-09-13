import 'package:flutter/material.dart';
import 'circle_button.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onTap;

  const EditButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircleButton(onTap: onTap, icon: Icons.edit_outlined);
  }
}
