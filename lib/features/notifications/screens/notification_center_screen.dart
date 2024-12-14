import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/notification_model.dart';
import '../providers/notification_provider.dart';
import '../widgets/notification_card.dart';

class NotificationCenterScreen extends StatelessWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
      child: const NotificationCenterContent(),
    );
  }
}

class NotificationCenterContent extends StatelessWidget {
  const NotificationCenterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, notificationProvider, child) {
        final hasSelectedNotifications =
            notificationProvider.selectedNotifications.isNotEmpty;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Notifications'),
            actions: [
              if (hasSelectedNotifications) ...[
                IconButton(
                  icon: const Icon(Icons.check_circle_outline),
                  onPressed: () {
                    notificationProvider.markSelectedAsRead();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Selected notifications marked as read'),
                      ),
                    );
                  },
                  tooltip: 'Mark selected as read',
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    notificationProvider.deleteSelectedNotifications();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Selected notifications deleted'),
                      ),
                    );
                  },
                  tooltip: 'Delete selected',
                ),
              ] else
                IconButton(
                  icon: const Icon(Icons.done_all),
                  onPressed: () {
                    notificationProvider.markAllAsRead();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('All notifications marked as read'),
                      ),
                    );
                  },
                  tooltip: 'Mark all as read',
                ),
            ],
          ),
          body: Column(
            children: [
              Material(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SegmentedButton<NotificationType>(
                    segments: const [
                      ButtonSegment(
                        value: NotificationType.upcomingDate,
                        label: Text('Upcoming Dates'),
                        icon: Icon(Icons.calendar_today),
                      ),
                      ButtonSegment(
                        value: NotificationType.reminder,
                        label: Text('Reminders'),
                        icon: Icon(Icons.alarm),
                      ),
                      ButtonSegment(
                        value: NotificationType.generalUpdate,
                        label: Text('Updates'),
                        icon: Icon(Icons.notifications),
                      ),
                    ],
                    selected: {notificationProvider.selectedFilter},
                    onSelectionChanged: (Set<NotificationType> selected) {
                      notificationProvider.setFilter(selected.first);
                    },
                  ),
                ),
              ),
              Expanded(
                child: notificationProvider.getFilteredNotifications().isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off_outlined,
                              size: 64,
                              color: Theme.of(context).disabledColor,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No notifications',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            notificationProvider.getFilteredNotifications().length,
                        itemBuilder: (context, index) {
                          final notification =
                              notificationProvider.getFilteredNotifications()[index];
                          return NotificationCard(
                            notification: notification,
                            isSelected: notificationProvider.selectedNotifications
                                .contains(notification.id),
                            onTap: () {
                              // Show notification details
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(notification.title),
                                  content: Text(notification.description),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            onToggleRead: () {
                              notificationProvider
                                  .toggleNotificationRead(notification.id);
                            },
                            onToggleSave: () {
                              notificationProvider
                                  .toggleNotificationSaved(notification.id);
                            },
                            onDelete: () {
                              notificationProvider
                                  .deleteNotification(notification.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Notification deleted'),
                                ),
                              );
                            },
                            onSelect: (selected) {
                              notificationProvider
                                  .toggleNotificationSelection(notification.id);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
