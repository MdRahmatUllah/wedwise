import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarWidget({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late PageController _pageController;
  late DateTime _focusedMonth;

  @override
  void initState() {
    super.initState();
    _focusedMonth =
        DateTime(widget.selectedDate.year, widget.selectedDate.month);
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _focusedMonth = DateTime(
        _focusedMonth.year,
        _focusedMonth.month + (page - _pageController.initialPage),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          SizedBox(
            height: 300,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                final month = DateTime(
                  _focusedMonth.year,
                  _focusedMonth.month + (index - _pageController.initialPage),
                );
                return _buildMonthCalendar(month);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
          Text(
            DateFormat('MMMM yyyy').format(_focusedMonth),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMonthCalendar(DateTime month) {
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;

    return Column(
      children: [
        _buildWeekdayHeader(),
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 42, // 6 weeks * 7 days
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final dayOffset = index - (firstWeekday - 1);
              final day = dayOffset + 1;

              if (dayOffset < 0 || day > daysInMonth) {
                return const SizedBox();
              }

              final date = DateTime(month.year, month.month, day);
              final isSelected = isSameDay(date, widget.selectedDate);
              final isToday = isSameDay(date, DateTime.now());

              return _buildDayCell(date, isSelected, isToday);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeekdayHeader() {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekdays
            .map((day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildDayCell(DateTime date, bool isSelected, bool isToday) {
    return InkWell(
      onTap: () => widget.onDateSelected(date),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : isToday
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.3)
                  : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            date.day.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : null,
                ),
          ),
        ),
      ),
    );
  }
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
