import 'package:flutter/material.dart';

class PreferencesSection extends StatelessWidget {
  final RangeValues budgetRange;
  final int guestCount;
  final String venueType;
  final List<String> selectedConsiderations;
  final Function(RangeValues) onBudgetChanged;
  final Function(int) onGuestCountChanged;
  final Function(String) onVenueTypeChanged;
  final Function(String) onConsiderationToggled;

  const PreferencesSection({
    super.key,
    required this.budgetRange,
    required this.guestCount,
    required this.venueType,
    required this.selectedConsiderations,
    required this.onBudgetChanged,
    required this.onGuestCountChanged,
    required this.onVenueTypeChanged,
    required this.onConsiderationToggled,
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
              'Preferences',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildBudgetSlider(context),
            const SizedBox(height: 16),
            _buildGuestCount(context),
            const SizedBox(height: 16),
            _buildVenueType(context),
            const SizedBox(height: 16),
            _buildConsiderations(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetSlider(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Budget Range',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        RangeSlider(
          values: budgetRange,
          min: 1000,
          max: 100000,
          divisions: 99,
          labels: RangeLabels(
            '\$${budgetRange.start.toStringAsFixed(0)}',
            '\$${budgetRange.end.toStringAsFixed(0)}',
          ),
          onChanged: onBudgetChanged,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${budgetRange.start.toStringAsFixed(0)}'),
            Text('\$${budgetRange.end.toStringAsFixed(0)}'),
          ],
        ),
      ],
    );
  }

  Widget _buildGuestCount(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Guest Count',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Enter expected number of guests',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            final count = int.tryParse(value);
            if (count != null) {
              onGuestCountChanged(count);
            }
          },
        ),
      ],
    );
  }

  Widget _buildVenueType(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Venue Type',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'Indoor', label: Text('Indoor')),
            ButtonSegment(value: 'Outdoor', label: Text('Outdoor')),
            ButtonSegment(value: 'Both', label: Text('Both')),
          ],
          selected: {venueType},
          onSelectionChanged: (Set<String> newSelection) {
            onVenueTypeChanged(newSelection.first);
          },
        ),
      ],
    );
  }

  Widget _buildConsiderations(BuildContext context) {
    final considerations = [
      'Religious/Cultural significance',
      'Weather conditions',
      'Local events',
      'Travel considerations',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Special Considerations',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        ...considerations.map((consideration) {
          return CheckboxListTile(
            title: Text(consideration),
            value: selectedConsiderations.contains(consideration),
            onChanged: (bool? value) {
              if (value != null) {
                onConsiderationToggled(consideration);
              }
            },
            contentPadding: EdgeInsets.zero,
          );
        }),
      ],
    );
  }
}
