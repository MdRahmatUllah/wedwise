import 'package:flutter/material.dart';
import '../models/calendar_event.dart';
import '../widgets/month_calendar.dart';
import '../widgets/event_list.dart';

class InteractiveCalendarScreen extends StatefulWidget {
  const InteractiveCalendarScreen({super.key});

  @override
  State<InteractiveCalendarScreen> createState() =>
      _InteractiveCalendarScreenState();
}

class _InteractiveCalendarScreenState extends State<InteractiveCalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  List<CalendarEvent> _events =
      []; // TODO: Replace with actual events from a provider

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() {
    // TODO: Load events from a data source
    setState(() {
      _events = [
        CalendarEvent(
          id: '1',
          title: 'Venue Visit',
          description: 'Visit potential wedding venues',
          startTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
          endTime: DateTime.now().add(const Duration(days: 1, hours: 4)),
          type: EventType.venueVisit,
          color: Colors.blue,
          location: 'Crystal Garden',
        ),
        CalendarEvent(
          id: '2',
          title: 'Cake Tasting',
          description: 'Sample wedding cakes',
          startTime: DateTime.now().add(const Duration(days: 2)),
          endTime: DateTime.now().add(const Duration(days: 2, hours: 1)),
          type: EventType.foodTasting,
          color: Colors.pink,
          location: 'Sweet Delights Bakery',
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: _goToToday,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshEvents,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MonthCalendar(
                selectedDate: _selectedDate,
                events: _events,
                onDateSelected: _onDateSelected,
                onMonthChanged: _onMonthChanged,
              ),
              EventList(
                events: _getEventsForSelectedDate(),
                onEventTap: _showEventDetails,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewEvent,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _onMonthChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    _loadEvents(); // Reload events for the new month
  }

  void _goToToday() {
    _onDateSelected(DateTime.now());
  }

  Future<void> _refreshEvents() async {
    // TODO: Implement refresh logic
    _loadEvents();
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('All Events'),
              onTap: () {
                // TODO: Implement filter
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Wedding Events'),
              onTap: () {
                // TODO: Implement filter
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Vendor Meetings'),
              onTap: () {
                // TODO: Implement filter
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Calendar'),
              onTap: () {
                // TODO: Implement share
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_download),
              title: const Text('Export Events'),
              onTap: () {
                // TODO: Implement export
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Calendar Settings'),
              onTap: () {
                // TODO: Implement settings
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _createNewEvent() {
    // TODO: Implement new event creation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Event'),
        content: const Text('Event creation form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Save new event
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEventDetails(CalendarEvent event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text(_formatEventDateTime(event)),
              ),
              if (event.location.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(event.location),
                ),
              ListTile(
                leading: const Icon(Icons.description),
                title: Text(event.description),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement edit
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Event'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement delete
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<CalendarEvent> _getEventsForSelectedDate() {
    return _events
        .where((event) => event.startTime.isSameDate(_selectedDate))
        .toList();
  }

  String _formatEventDateTime(CalendarEvent event) {
    if (event.isAllDay) {
      return 'All Day';
    }

    final start =
        '${event.startTime.hour}:${event.startTime.minute.toString().padLeft(2, '0')}';
    final end =
        '${event.endTime.hour}:${event.endTime.minute.toString().padLeft(2, '0')}';
    final date =
        '${event.startTime.day}/${event.startTime.month}/${event.startTime.year}';

    return '$date, $start - $end';
  }
}
