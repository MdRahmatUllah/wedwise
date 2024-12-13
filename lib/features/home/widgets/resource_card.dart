import 'package:flutter/material.dart';

class ResourceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const ResourceCard({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            // TODO: Implement resource details
          },
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
