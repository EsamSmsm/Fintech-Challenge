import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: ColorManager.itemBG,
        onTap: onTap,
        leading: Icon(icon, size: 40, color: ColorManager.secondary),
        title: Text(
          title,
          style: const TextStyle(color: ColorManager.primary),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: ColorManager.primary.withAlpha(200)),
        ),
      ),
    );
  }
}
