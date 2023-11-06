import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? radius;
  final double? fontSize;
  final Gradient? gradient;
  final void Function()? onPressed;
  final FontWeight? fontWeight;
  final double? spacing;
  final Widget? icon;
  final Color? borderColor;
  final bool hasShadow;
  final Color? shadowColor;
  final double shadowOpacity;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;
  final double? width;
  final double? verticalPadding;
  final bool disabled;

  const CustomButton({
    Key? key,
    this.icon,
    this.spacing,
    required this.text,
    required this.onPressed,
    this.fontWeight,
    this.gradient,
    this.backgroundColor,
    this.fontSize,
    this.foregroundColor,
    this.radius,
    this.borderColor,
    this.hasShadow = true,
    this.shadowColor,
    this.shadowOpacity = 0.3,
    this.shadowBlurRadius = 3,
    this.shadowSpreadRadius = 1,
    this.width,
    this.verticalPadding,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      elevation: 0,
      borderRadius: BorderRadius.circular(radius ?? 5),
      child: Container(
        padding: hasShadow ? EdgeInsets.all(5) : EdgeInsets.zero,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius ?? 5),
          onTap: !disabled ? onPressed : null,
          child: Ink(
            width: width ?? double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalPadding ?? 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 10),
              border: Border.all(color: borderColor ?? Colors.transparent),
              color: !disabled
                  ? backgroundColor ?? theme.primaryColor
                  : theme.primaryColor.withOpacity(0.5),
              gradient: gradient,
              boxShadow: !hasShadow || disabled
                  ? null
                  : [
                      BoxShadow(
                        color: (shadowColor ?? Colors.black).withOpacity(shadowOpacity),
                        spreadRadius: shadowSpreadRadius,
                        blurRadius: shadowBlurRadius,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: theme.textTheme.bodyText1?.copyWith(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: foregroundColor ?? Colors.white,
                  ),
                ),
                if (icon != null)
                  SizedBox(
                    width: spacing ?? 10,
                  ),
                if (icon != null) icon!
              ],
            ),
          ),
        ),
      ),
    );
  }
}
