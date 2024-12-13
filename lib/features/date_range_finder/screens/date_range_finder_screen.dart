import 'package:flutter/material.dart';
import '../widgets/range_selection.dart';
import '../widgets/preferences_section.dart';
import '../widgets/date_result_card.dart';

class DateRangeFinderScreen extends StatefulWidget {
  const DateRangeFinderScreen({super.key});

  @override
  State<DateRangeFinderScreen> createState() => _DateRangeFinderScreenState();
}

class _DateRangeFinderScreenState extends State<DateRangeFinderScreen> {
  late DateTimeRange _selectedRange;
  String _selectedSeason = 'Spring';
  bool _includeWeekends = true;
  RangeValues _budgetRange = const RangeValues(1000, 50000);
  int _guestCount = 100;
  String _venueType = 'Both';
  final List<String> _selectedConsiderations = [];
  List<Map<String, dynamic>> _results = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(days: 180)),
    );
    _searchDates();
  }

  Future<void> _searchDates() async {
    setState(() => _isLoading = true);
    // TODO: Implement actual date search logic
    await Future.delayed(const Duration(seconds: 2));

    // Simulated results
    setState(() {
      _results = List.generate(
        10,
        (index) => {
          'date': DateTime.now().add(Duration(days: index * 7)),
          'score': 8.0 - (index * 0.3),
          'weather': 'Sunny',
          'price': '\$${(5000 + index * 1000).toString()}',
          'isAvailable': index % 2 == 0,
        },
      );
      _isLoading = false;
    });
  }

  void _sortResults(String criteria) {
    setState(() {
      switch (criteria) {
        case 'score':
          _results.sort(
              (a, b) => (b['score'] as double).compareTo(a['score'] as double));
          break;
        case 'date':
          _results.sort((a, b) =>
              (a['date'] as DateTime).compareTo(b['date'] as DateTime));
          break;
        case 'price':
          _results.sort((a, b) => a['price'].compareTo(b['price']));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Best Dates'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: _sortResults,
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'score',
                child: Text('Sort by Score'),
              ),
              const PopupMenuItem(
                value: 'date',
                child: Text('Sort by Date'),
              ),
              const PopupMenuItem(
                value: 'price',
                child: Text('Sort by Price'),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _searchDates,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RangeSelection(
                      selectedRange: _selectedRange,
                      selectedSeason: _selectedSeason,
                      includeWeekends: _includeWeekends,
                      onRangeChanged: (range) {
                        setState(() => _selectedRange = range);
                        _searchDates();
                      },
                      onSeasonChanged: (season) {
                        setState(() => _selectedSeason = season);
                        _searchDates();
                      },
                      onWeekendPreferenceChanged: (value) {
                        setState(() => _includeWeekends = value);
                        _searchDates();
                      },
                    ),
                    PreferencesSection(
                      budgetRange: _budgetRange,
                      guestCount: _guestCount,
                      venueType: _venueType,
                      selectedConsiderations: _selectedConsiderations,
                      onBudgetChanged: (range) {
                        setState(() => _budgetRange = range);
                        _searchDates();
                      },
                      onGuestCountChanged: (count) {
                        setState(() => _guestCount = count);
                        _searchDates();
                      },
                      onVenueTypeChanged: (type) {
                        setState(() => _venueType = type);
                        _searchDates();
                      },
                      onConsiderationToggled: (consideration) {
                        setState(() {
                          if (_selectedConsiderations.contains(consideration)) {
                            _selectedConsiderations.remove(consideration);
                          } else {
                            _selectedConsiderations.add(consideration);
                          }
                        });
                        _searchDates();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Divider(),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final result = _results[index];
                        return DateResultCard(
                          date: result['date'] as DateTime,
                          score: result['score'] as double,
                          weather: result['weather'] as String,
                          price: result['price'] as String,
                          isAvailable: result['isAvailable'] as bool,
                          onTap: () {
                            // TODO: Navigate to detailed view
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Opening detailed view...'),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement save/export functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Saving results...'),
            ),
          );
        },
        icon: const Icon(Icons.save),
        label: const Text('Save Results'),
      ),
    );
  }
}
