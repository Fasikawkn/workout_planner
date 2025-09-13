import 'package:flutter/material.dart';
import 'circle_button.dart';

class CreateButton extends StatelessWidget {
  final VoidCallback onTap;

  const CreateButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircleButton(onTap: onTap, icon: Icons.add);
  }
}
