import 'package:flutter/material.dart';
import '../models/user_preferences.dart';

class EventPreferencesSection extends StatelessWidget {
  final Set<EventType> selectedEventTypes;
  final String customEventType;
  final String preferredTiming;
  final String preferredSeason;
  final Function(Set<EventType>) onEventTypesChanged;
  final Function(String) onCustomEventTypeChanged;
  final Function(String) onPreferredTimingChanged;
  final Function(String) onPreferredSeasonChanged;

  const EventPreferencesSection({
    super.key,
    required this.selectedEventTypes,
    required this.customEventType,
    required this.preferredTiming,
    required this.preferredSeason,
    required this.onEventTypesChanged,
    required this.onCustomEventTypeChanged,
    required this.onPreferredTimingChanged,
    required this.onPreferredSeasonChanged,
  });

  static const List<String> timings = [
    'Morning',
    'Afternoon',
    'Evening',
    'Night',
    'Any Time',
  ];

  static const List<String> seasons = [
    'Spring',
    'Summer',
    'Fall',
    'Winter',
    'Any Season',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Types',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: EventType.values.map((type) {
            return FilterChip(
              label: Text(type.name),
              selected: selectedEventTypes.contains(type),
              onSelected: (selected) {
                final newTypes = Set<EventType>.from(selectedEventTypes);
                if (selected) {
                  newTypes.add(type);
                } else {
                  newTypes.remove(type);
                }
                onEventTypesChanged(newTypes);
              },
            );
          }).toList(),
        ),
        if (selectedEventTypes.contains(EventType.other)) ...[
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Custom Event Type',
              border: OutlineInputBorder(),
              hintText: 'Enter custom event type',
            ),
            controller: TextEditingController(text: customEventType),
            onChanged: onCustomEventTypeChanged,
          ),
        ],
        const SizedBox(height: 16),
        Text(
          'Preferred Timing',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: preferredTiming.isEmpty ? timings.last : preferredTiming,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: timings
              .map((timing) => DropdownMenuItem(
                    value: timing,
                    child: Text(timing),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) onPreferredTimingChanged(value);
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Preferred Season',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: preferredSeason.isEmpty ? seasons.last : preferredSeason,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: seasons
              .map((season) => DropdownMenuItem(
                    value: season,
                    child: Text(season),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) onPreferredSeasonChanged(value);
          },
        ),
      ],
    );
  }
}
