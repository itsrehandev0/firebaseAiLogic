import 'package:firebase_ai_logic/widgets/primary_card.dart';
import 'package:flutter/material.dart';

class PrimaryTile extends StatelessWidget {
  const PrimaryTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.onTap,
  });
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      borderRadius: 16,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        title: Text(title),
        subtitle: Text(subTitle),
        leading: CircleAvatar(child: Icon(icon)),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}