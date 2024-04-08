import 'package:flutter/material.dart';
import 'package:gdtest/common/palette.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  const AppButton({
    required this.text,
    this.onPressed,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.red100,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon),
            if (icon != null) SizedBox(width: 24),
            Text(
              text,
              style: TextStyle(
                color: Palette.red500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
