import 'package:flutter/material.dart';
import 'package:grocery_app/util/shopping_colors.dart' as color;

class CustomIconButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 44,
      height: height ?? 44,
      child: Material(
        color: backgroundColor ?? color.backgroundColor,
        shape: borderColor == null ? const CircleBorder() : CircleBorder(
          side: BorderSide(color: borderColor!),
        ),
        child: InkWell(
          onTap: onPressed,
          child: icon,
          highlightColor: color.primaryColor.withOpacity(0.2),
          customBorder: const CircleBorder(),
        ),
      ),
    );
  }
}
