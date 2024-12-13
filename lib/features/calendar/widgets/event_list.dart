import 'package:flutter/material.dart';
import '../models/calendar_event.dart';

class EventList extends StatelessWidget {
  final List<CalendarEvent> events;
  final Function(CalendarEvent) onEventTap;

  const EventList({
    super.key,
    required this.events,
    required this.onEventTap,
  });

  @override
  Widget build(BuildContext context) {
    final groupedEvents = _groupEventsByDate();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groupedEvents.length,
      itemBuilder: (context, index) {
        final date = groupedEvents.keys.elementAt(index);
        final dateEvents = groupedEvents[date]!;
        return _buildDateSection(context, date, dateEvents);
      },
    );
  }

  Widget _buildDateSection(
    BuildContext context,
    DateTime date,
    List<CalendarEvent> dateEvents,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _formatDate(date),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...dateEvents.map((event) => _buildEventCard(context, event)),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context, CalendarEvent event) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: InkWell(
        onTap: () => onEventTap(event),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 50,
                decoration: BoxDecoration(
                  color: event.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatTimeRange(event),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (event.location.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            event.location,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: event.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  event.typeDisplayName,
                  style: TextStyle(
                    color: event.color,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<DateTime, List<CalendarEvent>> _groupEventsByDate() {
    final groupedEvents = <DateTime, List<CalendarEvent>>{};

    for (var event in events) {
      final date = DateTime(
        event.startTime.year,
        event.startTime.month,
        event.startTime.day,
      );

      if (!groupedEvents.containsKey(date)) {
        groupedEvents[date] = [];
      }

      groupedEvents[date]!.add(event);
    }

    return Map.fromEntries(
      groupedEvents.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    if (date.isSameDate(now)) {
      return 'Today';
    } else if (date.isSameDate(tomorrow)) {
      return 'Tomorrow';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatTimeRange(CalendarEvent event) {
    if (event.isAllDay) {
      return 'All Day';
    }

    final start =
        '${event.startTime.hour}:${event.startTime.minute.toString().padLeft(2, '0')}';
    final end =
        '${event.endTime.hour}:${event.endTime.minute.toString().padLeft(2, '0')}';

    return '$start - $end';
  }
}
