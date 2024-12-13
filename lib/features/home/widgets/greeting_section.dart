import 'package:flutter/material.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Icon(
            Icons.favorite,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const Text(
            'WedWise',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${_getGreeting()}, User!',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
