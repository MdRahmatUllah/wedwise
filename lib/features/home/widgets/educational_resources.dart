import 'package:flutter/material.dart';
import 'resource_card.dart';

class EducationalResources extends StatelessWidget {
  const EducationalResources({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Wedding Planning Tips',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              ResourceCard(
                title: 'Venue Selection Guide',
                icon: Icons.location_on,
                description: 'Tips for choosing the perfect wedding venue',
              ),
              ResourceCard(
                title: 'Budget Planning',
                icon: Icons.account_balance_wallet,
                description: 'How to manage your wedding expenses',
              ),
              ResourceCard(
                title: 'Wedding Checklist',
                icon: Icons.checklist,
                description: 'Complete timeline and planning checklist',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
