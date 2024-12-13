import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RangeSelection extends StatelessWidget {
  final DateTimeRange selectedRange;
  final String selectedSeason;
  final bool includeWeekends;
  final Function(DateTimeRange) onRangeChanged;
  final Function(String) onSeasonChanged;
  final Function(bool) onWeekendPreferenceChanged;

  const RangeSelection({
    super.key,
    required this.selectedRange,
    required this.selectedSeason,
    required this.includeWeekends,
    required this.onRangeChanged,
    required this.onSeasonChanged,
    required this.onWeekendPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Date Range',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildDateRangeSelector(context),
            const SizedBox(height: 16),
            _buildSeasonSelector(context),
            const SizedBox(height: 16),
            _buildWeekendToggle(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangeSelector(BuildContext context) {
    final dateFormat = DateFormat('MMM d, y');
    return InkWell(
      onTap: () async {
        final DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
          initialDateRange: selectedRange,
        );
        if (picked != null) {
          onRangeChanged(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.date_range),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${dateFormat.format(selectedRange.start)} - ${dateFormat.format(selectedRange.end)}',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeasonSelector(BuildContext context) {
    final seasons = ['Spring', 'Summer', 'Fall', 'Winter'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred Season',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: seasons.map((season) {
            return ChoiceChip(
              label: Text(season),
              selected: selectedSeason == season,
              onSelected: (selected) {
                if (selected) {
                  onSeasonChanged(season);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildWeekendToggle() {
    return SwitchListTile(
      title: const Text('Include Weekends'),
      value: includeWeekends,
      onChanged: onWeekendPreferenceChanged,
      contentPadding: EdgeInsets.zero,
    );
  }
}
