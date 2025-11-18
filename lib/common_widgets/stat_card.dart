import 'package:flutter/material.dart';
import 'package:noise_guard_app/core/theme/app_colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color subtitleColor;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.subtitleColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: DashboardColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Icon(icon, color: DashboardColors.subText, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 26),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(color: subtitleColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
