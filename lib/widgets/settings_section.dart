import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback? onMoreTap;
  final IconData? icon;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
    this.onMoreTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon,
                        size: 20, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
              if (onMoreTap != null)
                TextButton(
                  onPressed: onMoreTap,
                  child: const Text('More'),
                ),
            ],
          ),
        ),
        ...children,
        const Divider(height: 1),
      ],
    );
  }
}
