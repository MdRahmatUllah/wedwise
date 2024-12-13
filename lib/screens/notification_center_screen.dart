import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() =>
      _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<NotificationItem> _selectedNotifications = [];
  bool _isSelectionMode = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: _buildAppBarActions(),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming Dates'),
            Tab(text: 'Reminders'),
            Tab(text: 'Updates'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList(_getDummyUpcomingDates()),
          _buildNotificationList(_getDummyReminders()),
          _buildNotificationList(_getDummyGeneralUpdates()),
        ],
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSelectionMode) {
      return [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: _markSelectedAsRead,
          tooltip: 'Mark selected as read',
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: _deleteSelected,
          tooltip: 'Delete selected',
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.done_all),
          onPressed: _markAllAsRead,
          tooltip: 'Mark all as read',
        ),
      ];
    }
  }

  Widget _buildNotificationList(List<NotificationItem> notifications) {
    if (notifications.isEmpty) {
      return const Center(
        child: Text('No notifications'),
      );
    }

    return ListView.builder(
      itemCount: notifications.length,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _NotificationCard(
          notification: notification,
          isSelected: _selectedNotifications.contains(notification),
          isSelectionMode: _isSelectionMode,
          onLongPress: () {
            setState(() {
              _isSelectionMode = true;
              _selectedNotifications.add(notification);
            });
          },
          onTap: () {
            if (_isSelectionMode) {
              setState(() {
                if (_selectedNotifications.contains(notification)) {
                  _selectedNotifications.remove(notification);
                } else {
                  _selectedNotifications.add(notification);
                }
                if (_selectedNotifications.isEmpty) {
                  _isSelectionMode = false;
                }
              });
            }
          },
          onToggleRead: () {
            setState(() {
              notification.isRead = !notification.isRead;
            });
          },
          onToggleSave: () {
            setState(() {
              notification.isSaved = !notification.isSaved;
            });
          },
        );
      },
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in [
        ..._getDummyUpcomingDates(),
        ..._getDummyReminders(),
        ..._getDummyGeneralUpdates()
      ]) {
        notification.isRead = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications marked as read')),
    );
  }

  void _markSelectedAsRead() {
    setState(() {
      for (var notification in _selectedNotifications) {
        notification.isRead = true;
      }
      _selectedNotifications.clear();
      _isSelectionMode = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Selected notifications marked as read')),
    );
  }

  void _deleteSelected() {
    setState(() {
      _selectedNotifications.clear();
      _isSelectionMode = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Selected notifications deleted')),
    );
  }

  List<NotificationItem> _getDummyUpcomingDates() {
    return [
      NotificationItem(
        title: 'Auspicious Wedding Date',
        description: 'December 25, 2024 is highly auspicious for weddings',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: NotificationType.upcomingDate,
      ),
      NotificationItem(
        title: 'Engagement Ceremony Date',
        description: 'January 15, 2025 is perfect for engagement ceremonies',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        type: NotificationType.upcomingDate,
      ),
    ];
  }

  List<NotificationItem> _getDummyReminders() {
    return [
      NotificationItem(
        title: 'Venue Visit Scheduled',
        description: 'Remember to visit Crystal Garden tomorrow at 2 PM',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        type: NotificationType.reminder,
      ),
      NotificationItem(
        title: 'Catering Tasting',
        description: 'Food tasting session with Royal Caterers next week',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        type: NotificationType.reminder,
      ),
    ];
  }

  List<NotificationItem> _getDummyGeneralUpdates() {
    return [
      NotificationItem(
        title: 'New Feature Available',
        description: 'Try our new budget planning tool!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        type: NotificationType.generalUpdate,
      ),
      NotificationItem(
        title: 'Vendor Added',
        description: 'New premium decorator added to our vendor list',
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        type: NotificationType.generalUpdate,
      ),
    ];
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback onLongPress;
  final VoidCallback onTap;
  final VoidCallback onToggleRead;
  final VoidCallback onToggleSave;

  const _NotificationCard({
    required this.notification,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onLongPress,
    required this.onTap,
    required this.onToggleRead,
    required this.onToggleSave,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: isSelected ? 4 : 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: isSelected
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surface,
      child: InkWell(
        onLongPress: onLongPress,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSelectionMode)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: theme.colorScheme.primary,
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (!notification.isRead)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontWeight: notification.isRead
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notification.description,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatTimestamp(notification.timestamp),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      notification.isRead
                          ? Icons.mark_email_read
                          : Icons.mark_email_unread,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: onToggleRead,
                  ),
                  IconButton(
                    icon: Icon(
                      notification.isSaved
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: onToggleSave,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return DateFormat('MMM d, y').format(timestamp);
    }
  }
}

class NotificationItem {
  final String title;
  final String description;
  final DateTime timestamp;
  final NotificationType type;
  bool isRead;
  bool isSaved;

  NotificationItem({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    this.isSaved = false,
  });
}

enum NotificationType {
  upcomingDate,
  reminder,
  generalUpdate,
}
