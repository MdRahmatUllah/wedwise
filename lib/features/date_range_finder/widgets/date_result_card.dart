import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateResultCard extends StatelessWidget {
  final DateTime date;
  final double score;
  final String weather;
  final String price;
  final bool isAvailable;
  final VoidCallback onTap;

  const DateResultCard({
    super.key,
    required this.date,
    required this.score,
    required this.weather,
    required this.price,
    required this.isAvailable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEEE').format(date),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          DateFormat('MMMM d, y').format(date),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  _buildScoreBadge(context),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoChip(
                    context,
                    Icons.wb_sunny,
                    weather,
                    Theme.of(context).colorScheme.primary,
                  ),
                  _buildInfoChip(
                    context,
                    Icons.attach_money,
                    price,
                    Theme.of(context).colorScheme.secondary,
                  ),
                  _buildAvailabilityChip(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreBadge(BuildContext context) {
    final color = score >= 8.0
        ? Colors.green
        : score >= 6.0
            ? Colors.orange
            : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            score.toStringAsFixed(1),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityChip(BuildContext context) {
    final color = isAvailable ? Colors.green : Colors.red;
    final label = isAvailable ? 'Available' : 'Limited';
    final icon = isAvailable ? Icons.check_circle : Icons.warning;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
