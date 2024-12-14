import 'package:flutter/material.dart';

enum NotificationType {
  upcomingDate,
  reminder,
  generalUpdate,
}

class NotificationItem {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final NotificationType type;
  bool isRead;
  bool isSaved;

  NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    this.isSaved = false,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? timestamp,
    NotificationType? type,
    bool? isRead,
    bool? isSaved,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year(s) ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month(s) ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day(s) ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour(s) ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute(s) ago';
    } else {
      return 'Just now';
    }
  }

  IconData get typeIcon {
    switch (type) {
      case NotificationType.upcomingDate:
        return Icons.calendar_today;
      case NotificationType.reminder:
        return Icons.alarm;
      case NotificationType.generalUpdate:
        return Icons.notifications;
    }
  }

  Color getTypeColor(BuildContext context) {
    switch (type) {
      case NotificationType.upcomingDate:
        return Colors.blue;
      case NotificationType.reminder:
        return Colors.orange;
      case NotificationType.generalUpdate:
        return Colors.green;
    }
  }
}
