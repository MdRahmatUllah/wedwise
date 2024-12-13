import 'package:flutter/material.dart';
import 'quick_action_card.dart';
import '../../../features/date_analysis/screens/date_analysis_screen.dart';
import '../../../features/date_range_finder/screens/date_range_finder_screen.dart';
import '../../../features/calendar/screens/interactive_calendar_screen.dart';
import '../../../features/reports/screens/report_screen.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        QuickActionCard(
          title: 'Analyze Date',
          icon: Icons.calendar_today,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DateAnalysisScreen(),
              ),
            );
          },
          gradientColors: const [Colors.purple, Colors.deepPurple],
        ),
        QuickActionCard(
          title: 'Find Best Dates',
          icon: Icons.search,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DateRangeFinderScreen(),
              ),
            );
          },
          gradientColors: const [Colors.blue, Colors.lightBlue],
        ),
        QuickActionCard(
          title: 'Calendar',
          icon: Icons.calendar_month,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InteractiveCalendarScreen(),
              ),
            );
          },
          gradientColors: const [Colors.orange, Colors.deepOrange],
        ),
        QuickActionCard(
          title: 'Reports',
          icon: Icons.description,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ReportScreen(),
              ),
            );
          },
          gradientColors: const [Colors.green, Colors.lightGreen],
        ),
      ],
    );
  }
}
