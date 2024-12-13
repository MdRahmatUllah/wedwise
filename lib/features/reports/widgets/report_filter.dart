import 'package:flutter/material.dart';
import '../models/wedding_report.dart';

class ReportFilter extends StatelessWidget {
  final ReportType? selectedType;
  final Function(ReportType?) onFilterChanged;

  const ReportFilter({
    super.key,
    required this.selectedType,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _buildFilterChip(
            context,
            null,
            'All Reports',
            Icons.list,
            Colors.grey,
          ),
          const SizedBox(width: 8),
          ...ReportType.values.map((type) {
            final report = WeddingReport(
              id: '',
              title: '',
              type: type,
              generatedDate: DateTime.now(),
              data: {},
              summary: '',
              description: '',
            );
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: _buildFilterChip(
                context,
                type,
                report.typeDisplayName,
                report.typeIcon,
                report.typeColor,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    ReportType? type,
    String label,
    IconData icon,
    Color color,
  ) {
    final isSelected = selectedType == type;

    return FilterChip(
      selected: isSelected,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected ? Colors.white : color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : null,
            ),
          ),
        ],
      ),
      backgroundColor: color.withOpacity(0.1),
      selectedColor: color,
      onSelected: (selected) {
        onFilterChanged(selected ? type : null);
      },
    );
  }
}
