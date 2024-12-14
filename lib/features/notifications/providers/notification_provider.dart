import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  final List<NotificationItem> _notifications = [];
  NotificationType _selectedFilter = NotificationType.upcomingDate;
  final Set<String> _selectedNotifications = {};

  List<NotificationItem> get notifications => _notifications;
  NotificationType get selectedFilter => _selectedFilter;
  Set<String> get selectedNotifications => _selectedNotifications;
  bool get hasUnreadNotifications => _notifications.any((n) => !n.isRead);

  NotificationProvider() {
    _loadNotifications();
  }

  void _loadNotifications() {
    // TODO: Load from local storage or API
    // For now, adding sample notifications
    _notifications.addAll([
      NotificationItem(
        id: '1',
        title: 'Auspicious Date Alert',
        description: 'December 25, 2024, is highly auspicious for a wedding.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: NotificationType.upcomingDate,
      ),
      NotificationItem(
        id: '2',
        title: 'Wedding Planning Reminder',
        description: 'Don\'t forget to book your venue visit tomorrow!',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        type: NotificationType.reminder,
      ),
      NotificationItem(
        id: '3',
        title: 'New Feature Available',
        description: 'Check out our new budget planning tools!',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        type: NotificationType.generalUpdate,
      ),
    ]);
    notifyListeners();
  }

  List<NotificationItem> getFilteredNotifications() {
    return _notifications
        .where((notification) => notification.type == _selectedFilter)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  void setFilter(NotificationType type) {
    _selectedFilter = type;
    notifyListeners();
  }

  void toggleNotificationRead(String id) {
    final notification = _notifications.firstWhere((n) => n.id == id);
    notification.isRead = !notification.isRead;
    notifyListeners();
  }

  void toggleNotificationSaved(String id) {
    final notification = _notifications.firstWhere((n) => n.id == id);
    notification.isSaved = !notification.isSaved;
    notifyListeners();
  }

  void deleteNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    _selectedNotifications.remove(id);
    notifyListeners();
  }

  void markAllAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
    notifyListeners();
  }

  void toggleNotificationSelection(String id) {
    if (_selectedNotifications.contains(id)) {
      _selectedNotifications.remove(id);
    } else {
      _selectedNotifications.add(id);
    }
    notifyListeners();
  }

  void deleteSelectedNotifications() {
    _notifications.removeWhere((n) => _selectedNotifications.contains(n.id));
    _selectedNotifications.clear();
    notifyListeners();
  }

  void markSelectedAsRead() {
    for (var notification in _notifications) {
      if (_selectedNotifications.contains(notification.id)) {
        notification.isRead = true;
      }
    }
    _selectedNotifications.clear();
    notifyListeners();
  }
}
