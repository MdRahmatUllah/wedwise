import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/wedding_report.dart';

class ReportCard extends StatelessWidget {
  final WeddingReport report;
  final VoidCallback onTap;

  const ReportCard({
    super.key,
    required this.report,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: report.typeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      report.typeIcon,
                      color: report.typeColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Generated on ${DateFormat('MMM d, yyyy').format(report.generatedDate)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  if (report.isFavorite)
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                ],
              ),
              if (report.score > 0) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getScoreColor(report.score).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getScoreIcon(report.score),
                            size: 16,
                            color: _getScoreColor(report.score),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            report.scoreText,
                            style: TextStyle(
                              color: _getScoreColor(report.score),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      report.scoreDescription,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: _getScoreColor(report.score),
                          ),
                    ),
                  ],
                ),
              ],
              if (report.summary.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  report.summary,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (report.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: report.tags
                        .map((tag) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Chip(
                                label: Text(
                                  tag,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                                padding: const EdgeInsets.all(4),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
              if (report.recommendations.isNotEmpty) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.lightbulb_outline,
                      size: 16,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${report.recommendations.length} Recommendations',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.amber[700],
                          ),
                    ),
                  ],
                ),
              ],
              if (report.attachments.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.attach_file,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${report.attachments.length} Attachments',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.blue;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }

  IconData _getScoreIcon(double score) {
    if (score >= 80) return Icons.star;
    if (score >= 60) return Icons.thumb_up;
    if (score >= 40) return Icons.thumbs_up_down;
    return Icons.thumb_down;
  }
}
