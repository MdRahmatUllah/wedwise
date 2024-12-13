import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onShare;
  final VoidCallback onReport;
  final VoidCallback onBook;

  const ActionButtons({
    super.key,
    required this.onSave,
    required this.onShare,
    required this.onReport,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildActionButton(
              context,
              icon: Icons.favorite_border,
              label: 'Save',
              onPressed: onSave,
            ),
            _buildActionButton(
              context,
              icon: Icons.share,
              label: 'Share',
              onPressed: onShare,
            ),
            _buildActionButton(
              context,
              icon: Icons.description,
              label: 'Report',
              onPressed: onReport,
            ),
            _buildActionButton(
              context,
              icon: Icons.calendar_today,
              label: 'Book',
              onPressed: onBook,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
