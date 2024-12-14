import 'package:flutter/material.dart';

enum EventType {
  wedding,
  engagement,
  anniversary,
  other,
}

class UserPreferences {
  final String language;
  final ThemeMode themeMode;
  final double textScale;
  
  // Notification Settings
  final bool pushNotificationsEnabled;
  final bool emailNotificationsEnabled;
  final Map<String, bool> notificationTypes;
  final String notificationFrequency;
  
  // Cultural & Religious Preferences
  final List<String> culturalPreferences;
  final List<String> festivals;
  final Map<String, dynamic> customTraditions;
  
  // Zodiac & Astrological Preferences
  final String userZodiacSign;
  final String partnerZodiacSign;
  final bool considerPlanetaryAlignments;
  final bool considerMoonPhases;
  final bool excludeInauspiciousDates;
  
  // Event Preferences
  final Set<EventType> selectedEventTypes;
  final String customEventType;
  final String preferredTiming;
  final String preferredSeason;
  
  // Display Preferences
  final String currency;
  final String dateFormat;
  final String timeFormat;
  
  // Privacy Settings
  final bool twoFactorEnabled;
  final Map<String, bool> privacySettings;
  
  // App Settings
  final bool showBudgetInHome;
  final bool showTimelineInHome;
  final Map<String, dynamic> regionalData;

  UserPreferences({
    this.language = 'English',
    this.themeMode = ThemeMode.system,
    this.textScale = 1.0,
    this.pushNotificationsEnabled = true,
    this.emailNotificationsEnabled = true,
    this.notificationTypes = const {
      'reminders': true,
      'updates': true,
      'recommendations': true,
      'auspiciousDates': true,
    },
    this.notificationFrequency = 'daily',
    this.culturalPreferences = const [],
    this.festivals = const [],
    this.customTraditions = const {},
    this.userZodiacSign = '',
    this.partnerZodiacSign = '',
    this.considerPlanetaryAlignments = false,
    this.considerMoonPhases = false,
    this.excludeInauspiciousDates = false,
    this.selectedEventTypes = const {EventType.wedding},
    this.customEventType = '',
    this.preferredTiming = '',
    this.preferredSeason = '',
    this.currency = 'USD',
    this.dateFormat = 'MM/dd/yyyy',
    this.timeFormat = '12-hour',
    this.twoFactorEnabled = false,
    this.privacySettings = const {
      'shareProfile': false,
      'showProgress': true,
      'allowAnalytics': true,
    },
    this.showBudgetInHome = true,
    this.showTimelineInHome = true,
    this.regionalData = const {},
  });

  UserPreferences copyWith({
    String? language,
    ThemeMode? themeMode,
    double? textScale,
    bool? pushNotificationsEnabled,
    bool? emailNotificationsEnabled,
    Map<String, bool>? notificationTypes,
    String? notificationFrequency,
    List<String>? culturalPreferences,
    List<String>? festivals,
    Map<String, dynamic>? customTraditions,
    String? userZodiacSign,
    String? partnerZodiacSign,
    bool? considerPlanetaryAlignments,
    bool? considerMoonPhases,
    bool? excludeInauspiciousDates,
    Set<EventType>? selectedEventTypes,
    String? customEventType,
    String? preferredTiming,
    String? preferredSeason,
    String? currency,
    String? dateFormat,
    String? timeFormat,
    bool? twoFactorEnabled,
    Map<String, bool>? privacySettings,
    bool? showBudgetInHome,
    bool? showTimelineInHome,
    Map<String, dynamic>? regionalData,
  }) {
    return UserPreferences(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      textScale: textScale ?? this.textScale,
      pushNotificationsEnabled: pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      emailNotificationsEnabled: emailNotificationsEnabled ?? this.emailNotificationsEnabled,
      notificationTypes: notificationTypes ?? this.notificationTypes,
      notificationFrequency: notificationFrequency ?? this.notificationFrequency,
      culturalPreferences: culturalPreferences ?? this.culturalPreferences,
      festivals: festivals ?? this.festivals,
      customTraditions: customTraditions ?? this.customTraditions,
      userZodiacSign: userZodiacSign ?? this.userZodiacSign,
      partnerZodiacSign: partnerZodiacSign ?? this.partnerZodiacSign,
      considerPlanetaryAlignments: considerPlanetaryAlignments ?? this.considerPlanetaryAlignments,
      considerMoonPhases: considerMoonPhases ?? this.considerMoonPhases,
      excludeInauspiciousDates: excludeInauspiciousDates ?? this.excludeInauspiciousDates,
      selectedEventTypes: selectedEventTypes ?? this.selectedEventTypes,
      customEventType: customEventType ?? this.customEventType,
      preferredTiming: preferredTiming ?? this.preferredTiming,
      preferredSeason: preferredSeason ?? this.preferredSeason,
      currency: currency ?? this.currency,
      dateFormat: dateFormat ?? this.dateFormat,
      timeFormat: timeFormat ?? this.timeFormat,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      privacySettings: privacySettings ?? this.privacySettings,
      showBudgetInHome: showBudgetInHome ?? this.showBudgetInHome,
      showTimelineInHome: showTimelineInHome ?? this.showTimelineInHome,
      regionalData: regionalData ?? this.regionalData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'themeMode': themeMode.index,
      'textScale': textScale,
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'emailNotificationsEnabled': emailNotificationsEnabled,
      'notificationTypes': notificationTypes,
      'notificationFrequency': notificationFrequency,
      'culturalPreferences': culturalPreferences,
      'festivals': festivals,
      'customTraditions': customTraditions,
      'userZodiacSign': userZodiacSign,
      'partnerZodiacSign': partnerZodiacSign,
      'considerPlanetaryAlignments': considerPlanetaryAlignments,
      'considerMoonPhases': considerMoonPhases,
      'excludeInauspiciousDates': excludeInauspiciousDates,
      'selectedEventTypes': selectedEventTypes.map((e) => e.index).toList(),
      'customEventType': customEventType,
      'preferredTiming': preferredTiming,
      'preferredSeason': preferredSeason,
      'currency': currency,
      'dateFormat': dateFormat,
      'timeFormat': timeFormat,
      'twoFactorEnabled': twoFactorEnabled,
      'privacySettings': privacySettings,
      'showBudgetInHome': showBudgetInHome,
      'showTimelineInHome': showTimelineInHome,
      'regionalData': regionalData,
    };
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      language: json['language'] as String? ?? 'English',
      themeMode: ThemeMode.values[json['themeMode'] as int? ?? 0],
      textScale: (json['textScale'] as num?)?.toDouble() ?? 1.0,
      pushNotificationsEnabled: json['pushNotificationsEnabled'] as bool? ?? true,
      emailNotificationsEnabled: json['emailNotificationsEnabled'] as bool? ?? true,
      notificationTypes: Map<String, bool>.from(json['notificationTypes'] as Map? ?? {}),
      notificationFrequency: json['notificationFrequency'] as String? ?? 'daily',
      culturalPreferences: List<String>.from(json['culturalPreferences'] as List? ?? []),
      festivals: List<String>.from(json['festivals'] as List? ?? []),
      customTraditions: Map<String, dynamic>.from(json['customTraditions'] as Map? ?? {}),
      userZodiacSign: json['userZodiacSign'] as String? ?? '',
      partnerZodiacSign: json['partnerZodiacSign'] as String? ?? '',
      considerPlanetaryAlignments: json['considerPlanetaryAlignments'] as bool? ?? false,
      considerMoonPhases: json['considerMoonPhases'] as bool? ?? false,
      excludeInauspiciousDates: json['excludeInauspiciousDates'] as bool? ?? false,
      selectedEventTypes: (json['selectedEventTypes'] as List?)
              ?.map((e) => EventType.values[e as int])
              .toSet() ??
          {EventType.wedding},
      customEventType: json['customEventType'] as String? ?? '',
      preferredTiming: json['preferredTiming'] as String? ?? '',
      preferredSeason: json['preferredSeason'] as String? ?? '',
      currency: json['currency'] as String? ?? 'USD',
      dateFormat: json['dateFormat'] as String? ?? 'MM/dd/yyyy',
      timeFormat: json['timeFormat'] as String? ?? '12-hour',
      twoFactorEnabled: json['twoFactorEnabled'] as bool? ?? false,
      privacySettings: Map<String, bool>.from(json['privacySettings'] as Map? ?? {}),
      showBudgetInHome: json['showBudgetInHome'] as bool? ?? true,
      showTimelineInHome: json['showTimelineInHome'] as bool? ?? true,
      regionalData: Map<String, dynamic>.from(json['regionalData'] as Map? ?? {}),
    );
  }
}
