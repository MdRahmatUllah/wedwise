import 'package:flutter/material.dart';

class DetailedInfoCard extends StatelessWidget {
  final Map<String, String> weatherDetails;
  final Map<String, String> astrologicalInfo;
  final bool venueAvailable;
  final String priceTrend;

  const DetailedInfoCard({
    super.key,
    required this.weatherDetails,
    required this.astrologicalInfo,
    required this.venueAvailable,
    required this.priceTrend,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(
          'Detailed Information',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWeatherDetails(context),
                const Divider(height: 24),
                _buildAstrologicalInfo(context),
                const Divider(height: 24),
                _buildVenueInfo(context),
                const Divider(height: 24),
                _buildPriceTrend(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weather Details',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        ...weatherDetails.entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key),
                  Text(entry.value),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildAstrologicalInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Astrological Information',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        ...astrologicalInfo.entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key),
                  Text(entry.value),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildVenueInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Venue Availability',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              venueAvailable ? Icons.check_circle : Icons.cancel,
              color: venueAvailable
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: 8),
            Text(venueAvailable
                ? 'Venues are available'
                : 'Limited venue availability'),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceTrend(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Trend',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              priceTrend.contains('High')
                  ? Icons.trending_up
                  : Icons.trending_down,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(priceTrend),
          ],
        ),
      ],
    );
  }
}
