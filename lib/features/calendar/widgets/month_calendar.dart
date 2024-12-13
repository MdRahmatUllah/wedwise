import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/calendar_event.dart';

class MonthCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final List<CalendarEvent> events;
  final Function(DateTime) onDateSelected;
  final Function(DateTime) onMonthChanged;

  const MonthCalendar({
    super.key,
    required this.selectedDate,
    required this.events,
    required this.onDateSelected,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        _buildCalendarGrid(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _changeMonth(context, -1),
          ),
          Text(
            DateFormat('MMMM yyyy').format(selectedDate),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _changeMonth(context, 1),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 42, // 6 weeks * 7 days
      itemBuilder: (context, index) {
        final date = _getDateForIndex(index);
        return _buildDateCell(context, date);
      },
    );
  }

  Widget _buildDateCell(BuildContext context, DateTime date) {
    final isSelected = date.isSameDate(selectedDate);
    final isToday = date.isSameDate(DateTime.now());
    final eventsForDay =
        events.where((event) => event.startTime.isSameDate(date)).toList();
    final isCurrentMonth = date.month == selectedDate.month;

    return InkWell(
      onTap: () => onDateSelected(date),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : isToday
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.3)
                  : null,
          borderRadius: BorderRadius.circular(8),
          border: isToday
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.day.toString(),
              style: TextStyle(
                color: !isCurrentMonth
                    ? Theme.of(context).disabledColor
                    : isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : null,
                fontWeight: isToday ? FontWeight.bold : null,
              ),
            ),
            if (eventsForDay.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: eventsForDay.first.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (eventsForDay.length > 1) ...[
                    const SizedBox(width: 2),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: eventsForDay[1].color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _changeMonth(BuildContext context, int monthDelta) {
    final newDate = DateTime(
      selectedDate.year,
      selectedDate.month + monthDelta,
      1,
    );
    onMonthChanged(newDate);
  }

  DateTime _getDateForIndex(int index) {
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final firstDayWeekday = firstDayOfMonth.weekday;
    final daysBeforeMonth = firstDayWeekday - 1;

    return firstDayOfMonth.subtract(
      Duration(days: daysBeforeMonth - index),
    );
  }
}
