import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_preferences.dart';

class SettingsProvider with ChangeNotifier {
  UserPreferences _preferences = UserPreferences();
  bool _isLoading = false;
  String? _error;

  UserPreferences get preferences => _preferences;
  bool get isLoading => _isLoading;
  String? get error => _error;

  SettingsProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final prefsJson = prefs.getString('user_preferences');
      if (prefsJson != null) {
        _preferences = UserPreferences.fromJson(
          Map<String, dynamic>.from(
            const JsonDecoder().convert(prefsJson) as Map,
          ),
        );
      }
    } catch (e) {
      _error = 'Error loading preferences: $e';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> savePreferences() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'user_preferences',
        const JsonEncoder().convert(_preferences.toJson()),
      );
    } catch (e) {
      _error = 'Error saving preferences: $e';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updatePreferences(UserPreferences newPreferences) {
    _preferences = newPreferences;
    notifyListeners();
    savePreferences();
  }

  void resetPreferences() {
    _preferences = UserPreferences();
    notifyListeners();
    savePreferences();
  }

  // Helper methods for common updates
  void setThemeMode(ThemeMode mode) {
    updatePreferences(_preferences.copyWith(themeMode: mode));
  }

  void setLanguage(String language) {
    updatePreferences(_preferences.copyWith(language: language));
  }

  void setTextScale(double scale) {
    updatePreferences(_preferences.copyWith(textScale: scale));
  }

  void togglePushNotifications(bool enabled) {
    updatePreferences(_preferences.copyWith(pushNotificationsEnabled: enabled));
  }

  void toggleEmailNotifications(bool enabled) {
    updatePreferences(
        _preferences.copyWith(emailNotificationsEnabled: enabled));
  }

  void updateNotificationTypes(Map<String, bool> types) {
    updatePreferences(_preferences.copyWith(notificationTypes: types));
  }

  void setNotificationFrequency(String frequency) {
    updatePreferences(_preferences.copyWith(notificationFrequency: frequency));
  }

  void updateCulturalPreferences(List<String> preferences) {
    updatePreferences(_preferences.copyWith(culturalPreferences: preferences));
  }

  void updateFestivals(List<String> festivals) {
    updatePreferences(_preferences.copyWith(festivals: festivals));
  }

  void updateCustomTraditions(Map<String, dynamic> traditions) {
    updatePreferences(_preferences.copyWith(customTraditions: traditions));
  }

  void setZodiacSigns(String userSign, String partnerSign) {
    updatePreferences(_preferences.copyWith(
      userZodiacSign: userSign,
      partnerZodiacSign: partnerSign,
    ));
  }

  void toggleAstrologicalPreferences({
    bool? planetaryAlignments,
    bool? moonPhases,
    bool? excludeInauspicious,
  }) {
    updatePreferences(_preferences.copyWith(
      considerPlanetaryAlignments: planetaryAlignments,
      considerMoonPhases: moonPhases,
      excludeInauspiciousDates: excludeInauspicious,
    ));
  }

  void updateEventTypes(Set<EventType> types, {String? customType}) {
    updatePreferences(_preferences.copyWith(
      selectedEventTypes: types,
      customEventType: customType,
    ));
  }

  void updateEventPreferences({String? timing, String? season}) {
    updatePreferences(_preferences.copyWith(
      preferredTiming: timing,
      preferredSeason: season,
    ));
  }

  void updateDisplayPreferences({
    String? currency,
    String? dateFormat,
    String? timeFormat,
  }) {
    updatePreferences(_preferences.copyWith(
      currency: currency,
      dateFormat: dateFormat,
      timeFormat: timeFormat,
    ));
  }

  void toggleTwoFactor(bool enabled) {
    updatePreferences(_preferences.copyWith(twoFactorEnabled: enabled));
  }

  void updatePrivacySettings(Map<String, bool> settings) {
    updatePreferences(_preferences.copyWith(privacySettings: settings));
  }

  void updateHomeScreenPreferences({bool? showBudget, bool? showTimeline}) {
    updatePreferences(_preferences.copyWith(
      showBudgetInHome: showBudget,
      showTimelineInHome: showTimeline,
    ));
  }

  void updateRegionalData(Map<String, dynamic> data) {
    updatePreferences(_preferences.copyWith(regionalData: data));
  }
}
