import 'package:firebase_ai_logic/utilities/app_color.dart';
import 'package:firebase_ai_logic/widgets/primary_card.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.text, this.onTap});
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryCard(
            onTap: onTap,
            borderColor: AppColor.backgroundColor,
            width: 2,
            borderRadius: 16,
            backgroundColor: AppColor.backgroundColor.withValues(alpha: 0.5),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                text,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
