import 'package:flutter/material.dart';

class UserPreferences {
  final String language;
  final ThemeMode themeMode;
  final bool notificationsEnabled;
  final Map<String, bool> notificationTypes;
  final String currency;
  final String dateFormat;
  final String timeFormat;
  final bool showBudgetInHome;
  final bool showTimelineInHome;
  final Map<String, bool> privacySettings;
  final Map<String, dynamic> culturalPreferences;

  UserPreferences({
    this.language = 'English',
    this.themeMode = ThemeMode.system,
    this.notificationsEnabled = true,
    this.notificationTypes = const {
      'reminders': true,
      'updates': true,
      'recommendations': true,
      'promotions': false,
    },
    this.currency = 'USD',
    this.dateFormat = 'MM/dd/yyyy',
    this.timeFormat = '12-hour',
    this.showBudgetInHome = true,
    this.showTimelineInHome = true,
    this.privacySettings = const {
      'shareProfile': false,
      'showProgress': true,
      'allowAnalytics': true,
    },
    this.culturalPreferences = const {},
  });

  UserPreferences copyWith({
    String? language,
    ThemeMode? themeMode,
    bool? notificationsEnabled,
    Map<String, bool>? notificationTypes,
    String? currency,
    String? dateFormat,
    String? timeFormat,
    bool? showBudgetInHome,
    bool? showTimelineInHome,
    Map<String, bool>? privacySettings,
    Map<String, dynamic>? culturalPreferences,
  }) {
    return UserPreferences(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      notificationTypes: notificationTypes ?? this.notificationTypes,
      currency: currency ?? this.currency,
      dateFormat: dateFormat ?? this.dateFormat,
      timeFormat: timeFormat ?? this.timeFormat,
      showBudgetInHome: showBudgetInHome ?? this.showBudgetInHome,
      showTimelineInHome: showTimelineInHome ?? this.showTimelineInHome,
      privacySettings: privacySettings ?? this.privacySettings,
      culturalPreferences: culturalPreferences ?? this.culturalPreferences,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'themeMode': themeMode.index,
      'notificationsEnabled': notificationsEnabled,
      'notificationTypes': notificationTypes,
      'currency': currency,
      'dateFormat': dateFormat,
      'timeFormat': timeFormat,
      'showBudgetInHome': showBudgetInHome,
      'showTimelineInHome': showTimelineInHome,
      'privacySettings': privacySettings,
      'culturalPreferences': culturalPreferences,
    };
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      language: json['language'] as String? ?? 'English',
      themeMode: ThemeMode.values[json['themeMode'] as int? ?? 0],
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      notificationTypes: Map<String, bool>.from(json['notificationTypes'] as Map? ?? {}),
      currency: json['currency'] as String? ?? 'USD',
      dateFormat: json['dateFormat'] as String? ?? 'MM/dd/yyyy',
      timeFormat: json['timeFormat'] as String? ?? '12-hour',
      showBudgetInHome: json['showBudgetInHome'] as bool? ?? true,
      showTimelineInHome: json['showTimelineInHome'] as bool? ?? true,
      privacySettings: Map<String, bool>.from(json['privacySettings'] as Map? ?? {}),
      culturalPreferences: Map<String, dynamic>.from(json['culturalPreferences'] as Map? ?? {}),
    );
  }
}
