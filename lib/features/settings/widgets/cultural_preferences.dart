import 'package:flutter/material.dart';
import '../models/user_preferences.dart';

class CulturalPreferencesSection extends StatelessWidget {
  final List<String> selectedPreferences;
  final List<String> selectedFestivals;
  final Function(List<String>) onPreferencesChanged;
  final Function(List<String>) onFestivalsChanged;

  const CulturalPreferencesSection({
    super.key,
    required this.selectedPreferences,
    required this.selectedFestivals,
    required this.onPreferencesChanged,
    required this.onFestivalsChanged,
  });

  static const List<String> availableCultures = [
    'Hindu',
    'Christian',
    'Islamic',
    'Buddhist',
    'Sikh',
    'Traditional',
    'Modern',
    'Mixed',
  ];

  static const List<String> availableFestivals = [
    'Diwali',
    'Christmas',
    'Eid',
    'Vesak',
    'Vaisakhi',
    'Lunar New Year',
    'Thanksgiving',
    'Easter',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cultural Background',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: availableCultures.map((culture) {
            final isSelected = selectedPreferences.contains(culture);
            return FilterChip(
              label: Text(culture),
              selected: isSelected,
              onSelected: (selected) {
                final newPreferences = List<String>.from(selectedPreferences);
                if (selected) {
                  newPreferences.add(culture);
                } else {
                  newPreferences.remove(culture);
                }
                onPreferencesChanged(newPreferences);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Text(
          'Important Festivals',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: availableFestivals.map((festival) {
            final isSelected = selectedFestivals.contains(festival);
            return FilterChip(
              label: Text(festival),
              selected: isSelected,
              onSelected: (selected) {
                final newFestivals = List<String>.from(selectedFestivals);
                if (selected) {
                  newFestivals.add(festival);
                } else {
                  newFestivals.remove(festival);
                }
                onFestivalsChanged(newFestivals);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {
            // TODO: Implement custom festival/tradition dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Add Custom Festival'),
                content: const Text('This feature is coming soon!'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Custom Festival'),
        ),
      ],
    );
  }
}
