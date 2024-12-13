import 'package:flutter/material.dart';
import '../widgets/greeting_section.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/featured_date_card.dart';
import '../widgets/educational_resources.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          GreetingSection(),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: QuickActionsGrid(),
          ),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: FeaturedDateCard(),
          ),
          SizedBox(height: 24),
          EducationalResources(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
