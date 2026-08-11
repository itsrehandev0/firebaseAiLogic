import 'package:firebase_ai_logic/utilities/app_color.dart';
import 'package:firebase_ai_logic/utilities/constant.dart';
import 'package:flutter/material.dart';

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    super.key,
    this.borderColor,
    this.borderRadius = kBorderRadius,
    this.width,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.onTap,
    required this.child,
  });
  final Color? borderColor;
  final double borderRadius;
  final double? width;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.zero,
        margin: margin ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          border: borderColor != null
              ? Border.all(
                  color: borderColor ?? AppColor.cardColor,
                  width: width ?? 1,
                )
              : null,
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
        ),
        child: child,
      ),
    );
  }
}
