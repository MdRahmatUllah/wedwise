import 'package:flutter/material.dart';

class AstrologicalPreferencesSection extends StatelessWidget {
  final String userZodiacSign;
  final String partnerZodiacSign;
  final bool considerPlanetaryAlignments;
  final bool considerMoonPhases;
  final bool excludeInauspiciousDates;
  final Function(String) onUserZodiacChanged;
  final Function(String) onPartnerZodiacChanged;
  final Function(bool) onPlanetaryAlignmentsChanged;
  final Function(bool) onMoonPhasesChanged;
  final Function(bool) onExcludeInauspiciousChanged;

  const AstrologicalPreferencesSection({
    super.key,
    required this.userZodiacSign,
    required this.partnerZodiacSign,
    required this.considerPlanetaryAlignments,
    required this.considerMoonPhases,
    required this.excludeInauspiciousDates,
    required this.onUserZodiacChanged,
    required this.onPartnerZodiacChanged,
    required this.onPlanetaryAlignmentsChanged,
    required this.onMoonPhasesChanged,
    required this.onExcludeInauspiciousChanged,
  });

  static const List<String> zodiacSigns = [
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Virgo',
    'Libra',
    'Scorpio',
    'Sagittarius',
    'Capricorn',
    'Aquarius',
    'Pisces',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Zodiac Sign',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: userZodiacSign.isEmpty ? null : userZodiacSign,
          decoration: const InputDecoration(
            hintText: 'Select your zodiac sign',
            border: OutlineInputBorder(),
          ),
          items: zodiacSigns
              .map((sign) => DropdownMenuItem(
                    value: sign,
                    child: Text(sign),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) onUserZodiacChanged(value);
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Partner\'s Zodiac Sign',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: partnerZodiacSign.isEmpty ? null : partnerZodiacSign,
          decoration: const InputDecoration(
            hintText: 'Select partner\'s zodiac sign',
            border: OutlineInputBorder(),
          ),
          items: zodiacSigns
              .map((sign) => DropdownMenuItem(
                    value: sign,
                    child: Text(sign),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) onPartnerZodiacChanged(value);
          },
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        Text(
          'Astrological Preferences',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('Consider Planetary Alignments'),
          subtitle: const Text('Include planetary positions in date calculations'),
          value: considerPlanetaryAlignments,
          onChanged: onPlanetaryAlignmentsChanged,
        ),
        SwitchListTile(
          title: const Text('Consider Moon Phases'),
          subtitle: const Text('Include moon phases in date calculations'),
          value: considerMoonPhases,
          onChanged: onMoonPhasesChanged,
        ),
        SwitchListTile(
          title: const Text('Exclude Inauspicious Dates'),
          subtitle: const Text('Filter out traditionally inauspicious dates'),
          value: excludeInauspiciousDates,
          onChanged: onExcludeInauspiciousChanged,
        ),
      ],
    );
  }
}
