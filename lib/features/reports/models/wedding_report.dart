import 'package:flutter/material.dart';

enum ReportType {
  budget,
  timeline,
  vendor,
  guest,
  custom
}

class WeddingReport {
  final String id;
  final String title;
  final String description;
  final ReportType type;
  final DateTime generatedDate;
  final Map<String, dynamic> data;
  final String summary;
  final List<String> recommendations;
  final List<String> attachments;
  final bool isFavorite;
  final double score;
  final List<String> tags;

  WeddingReport({
    required this.id,
    required this.title,
    required this.description,
    required this.generatedDate,
    required this.type,
    required this.data,
    required this.summary,
    this.recommendations = const [],
    this.attachments = const [],
    this.isFavorite = false,
    this.score = 0.0,
    this.tags = const [],
  });

  String get typeDisplayName {
    return type.toString().split('.').last.toUpperCase();
  }

  Color get typeColor {
    switch (type) {
      case ReportType.budget:
        return Colors.green;
      case ReportType.timeline:
        return Colors.blue;
      case ReportType.vendor:
        return Colors.purple;
      case ReportType.guest:
        return Colors.orange;
      case ReportType.custom:
        return Colors.grey;
    }
  }

  IconData get typeIcon {
    switch (type) {
      case ReportType.budget:
        return Icons.attach_money;
      case ReportType.timeline:
        return Icons.timeline;
      case ReportType.vendor:
        return Icons.business;
      case ReportType.guest:
        return Icons.people;
      case ReportType.custom:
        return Icons.description;
    }
  }

  String get scoreText {
    if (score <= 0) return '';
    return '${score.toStringAsFixed(0)}/100';
  }

  String get scoreDescription {
    if (score >= 80) return 'Highly Auspicious';
    if (score >= 60) return 'Auspicious';
    if (score >= 40) return 'Moderately Auspicious';
    return 'Less Auspicious';
  }
}
