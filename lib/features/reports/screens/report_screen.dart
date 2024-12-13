import 'package:flutter/material.dart';
import '../models/wedding_report.dart';
import '../widgets/report_card.dart';
import '../widgets/report_filter.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  ReportType? _selectedType;
  List<WeddingReport> _reports =
      []; // TODO: Replace with actual reports from a provider
  bool _isLoading = false;
  bool _isSelectionMode = false;
  final Set<String> _selectedReportIds = {};

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() {
      _isLoading = true;
    });

    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _reports = [
        WeddingReport(
          id: '1',
          title: 'Budget Overview Q4 2024',
          type: ReportType.budget,
          generatedDate: DateTime.now(),
          data: {
            'totalBudget': 50000,
            'spent': 20000,
            'remaining': 30000,
          },
          summary:
              'Current spending is within budget. Major expenses coming up in venue booking.',
          recommendations: [
            'Consider booking venue during off-peak season',
            'Look for package deals with preferred vendors',
          ],
          description: '',
        ),
        WeddingReport(
          id: '2',
          title: 'Wedding Timeline Progress',
          type: ReportType.timeline,
          generatedDate: DateTime.now().subtract(const Duration(days: 2)),
          data: {
            'completedTasks': 15,
            'pendingTasks': 25,
            'upcomingDeadlines': 5,
          },
          summary:
              'Timeline is on track. Some vendor meetings scheduled for next week.',
          recommendations: [
            'Start dress fittings within next 2 weeks',
            'Finalize catering menu',
          ],
          attachments: ['timeline.pdf', 'checklist.xlsx'],
          description: '',
        ),
      ];
      _isLoading = false;
    });
  }

  List<WeddingReport> get _filteredReports {
    if (_selectedType == null) return _reports;
    return _reports.where((report) => report.type == _selectedType).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Reports'),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearch,
          ),
          if (_isSelectionMode) ...[
            IconButton(
              icon: const Icon(Icons.share),
              onPressed:
                  _selectedReportIds.isEmpty ? null : _shareSelectedReports,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed:
                  _selectedReportIds.isEmpty ? null : _deleteSelectedReports,
            ),
          ] else
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: _showMoreOptions,
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadReports,
        child: Column(
          children: [
            ReportFilter(
              selectedType: _selectedType,
              onFilterChanged: (type) {
                setState(() {
                  _selectedType = type;
                });
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredReports.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          itemCount: _filteredReports.length,
                          itemBuilder: (context, index) {
                            final report = _filteredReports[index];
                            return Dismissible(
                              key: Key(report.id),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 16),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) => _deleteReport(report),
                              child: InkWell(
                                onLongPress: () {
                                  setState(() {
                                    _isSelectionMode = true;
                                    _selectedReportIds.add(report.id);
                                  });
                                },
                                child: Stack(
                                  children: [
                                    ReportCard(
                                      report: report,
                                      onTap: _isSelectionMode
                                          ? () {
                                              setState(() {
                                                if (_selectedReportIds
                                                    .contains(report.id)) {
                                                  _selectedReportIds
                                                      .remove(report.id);
                                                  if (_selectedReportIds
                                                      .isEmpty) {
                                                    _isSelectionMode = false;
                                                  }
                                                } else {
                                                  _selectedReportIds
                                                      .add(report.id);
                                                }
                                              });
                                            }
                                          : () => _showReportDetails(report),
                                    ),
                                    if (_isSelectionMode)
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: _selectedReportIds
                                                    .contains(report.id)
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Colors.grey.withOpacity(0.5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Icon(
                                              Icons.check,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateNewReport,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Reports Found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedType == null
                ? 'Generate your first wedding planning report'
                : 'No ${_selectedType.toString().split('.').last} reports available',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _generateNewReport,
            icon: const Icon(Icons.add),
            label: const Text('Generate Report'),
          ),
        ],
      ),
    );
  }

  void _showSearch() {
    // TODO: Implement search functionality
    showSearch(
      context: context,
      delegate: _ReportSearchDelegate(_reports),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.sort),
              title: const Text('Sort Reports'),
              onTap: () {
                // TODO: Implement sort
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_download),
              title: const Text('Export All Reports'),
              onTap: () {
                // TODO: Implement export
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Clear All Reports'),
              onTap: () {
                // TODO: Implement clear
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _generateNewReport() {
    // TODO: Implement report generation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Generate New Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.attach_money, color: Colors.green),
              title: const Text('Budget Report'),
              onTap: () {
                // TODO: Generate budget report
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.timeline, color: Colors.blue),
              title: const Text('Timeline Report'),
              onTap: () {
                // TODO: Generate timeline report
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.business, color: Colors.purple),
              title: const Text('Vendor Report'),
              onTap: () {
                // TODO: Generate vendor report
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Colors.orange),
              title: const Text('Guest List Report'),
              onTap: () {
                // TODO: Generate guest list report
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showReportDetails(WeddingReport report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    report.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                leading: Icon(report.typeIcon, color: report.typeColor),
                title: Text(report.typeDisplayName),
                subtitle:
                    Text('Generated on ${report.generatedDate.toString()}'),
              ),
              const SizedBox(height: 16),
              Text(
                'Summary',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(report.summary),
              if (report.recommendations.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Recommendations',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ...report.recommendations.map((rec) => ListTile(
                      leading: const Icon(Icons.lightbulb_outline),
                      title: Text(rec),
                    )),
              ],
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement share
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.share),
                label: const Text('Share Report'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement download
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.file_download),
                label: const Text('Download PDF'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _shareSelectedReports() {
    // TODO: Implement sharing multiple reports
    setState(() {
      _isSelectionMode = false;
      _selectedReportIds.clear();
    });
  }

  void _deleteSelectedReports() {
    setState(() {
      _reports.removeWhere((report) => _selectedReportIds.contains(report.id));
      _isSelectionMode = false;
      _selectedReportIds.clear();
    });
  }

  void _deleteReport(WeddingReport report) {
    setState(() {
      _reports.removeWhere((r) => r.id == report.id);
    });
  }
}

class _ReportSearchDelegate extends SearchDelegate<WeddingReport?> {
  final List<WeddingReport> reports;

  _ReportSearchDelegate(this.reports);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final filteredReports = reports.where((report) {
      return report.title.toLowerCase().contains(query.toLowerCase()) ||
          report.summary.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredReports.length,
      itemBuilder: (context, index) {
        final report = filteredReports[index];
        return ListTile(
          leading: Icon(report.typeIcon, color: report.typeColor),
          title: Text(report.title),
          subtitle: Text(report.summary),
          onTap: () {
            close(context, report);
          },
        );
      },
    );
  }
}
