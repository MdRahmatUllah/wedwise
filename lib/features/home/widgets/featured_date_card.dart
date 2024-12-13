import 'package:flutter/material.dart';

class FeaturedDateCard extends StatelessWidget {
  const FeaturedDateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              const Text(
                'Featured Auspicious Date',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'December 25, 2024',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'A perfect day for a winter wonderland wedding.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement view details
            },
            child: const Text('Learn More'),
          ),
        ],
      ),
    );
  }
}
