import 'package:flutter/material.dart';

enum EventType {
  weddingDay,
  vendorMeeting,
  venueVisit,
  dressFitting,
  foodTasting,
  planningMeeting,
  taskDeadline,
  custom
}

class CalendarEvent {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final EventType type;
  final Color color;
  final String location;
  final List<String> attendees;
  final bool isAllDay;
  final List<String> notes;
  final List<String> attachments;
  final bool hasReminder;
  final int priority;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.color,
    this.location = '',
    this.attendees = const [],
    this.isAllDay = false,
    this.notes = const [],
    this.attachments = const [],
    this.hasReminder = false,
    this.priority = 0,
  });

  bool get isMultiDay {
    return !startTime.isSameDate(endTime);
  }

  String get typeDisplayName {
    return type.toString().split('.').last.toUpperCase();
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
