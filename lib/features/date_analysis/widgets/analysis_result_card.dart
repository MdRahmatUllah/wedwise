import 'package:flutter/material.dart';

class AnalysisResultCard extends StatelessWidget {
  final double auspiciousRating;
  final String weatherForecast;
  final List<String> localEvents;
  final String culturalSignificance;

  const AnalysisResultCard({
    super.key,
    required this.auspiciousRating,
    required this.weatherForecast,
    required this.localEvents,
    required this.culturalSignificance,
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
            _buildRatingSection(context),
            const Divider(height: 24),
            _buildWeatherSection(context),
            const Divider(height: 24),
            _buildEventsSection(context),
            const Divider(height: 24),
            _buildCulturalSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Auspicious Rating',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < (auspiciousRating / 2).round()
                  ? Icons.star
                  : Icons.star_border,
              color: Theme.of(context).colorScheme.primary,
            );
          }),
        ),
      ],
    );
  }

  Widget _buildWeatherSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weather Forecast',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(weatherForecast),
      ],
    );
  }

  Widget _buildEventsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Local Events',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ...localEvents.map((event) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.event, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(event)),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildCulturalSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cultural Significance',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(culturalSignificance),
      ],
    );
  }
}
