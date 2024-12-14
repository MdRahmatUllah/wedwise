import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_section.dart';
import '../widgets/cultural_preferences.dart';
import '../widgets/astrological_preferences.dart';
import '../widgets/event_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const SettingsContent(),
    );
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        if (settingsProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final prefs = settingsProvider.preferences;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            actions: [
              IconButton(
                icon: const Icon(Icons.restore),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Reset Settings'),
                      content: const Text(
                        'Are you sure you want to reset all settings to default?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            settingsProvider.resetPreferences();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Settings reset to default'),
                              ),
                            );
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                  );
                },
                tooltip: 'Reset to defaults',
              ),
            ],
          ),
          body: ListView(
            children: [
              // Profile Section
              Card(
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.person, size: 40),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'John Doe',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'john.doe@example.com',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () {
                          // TODO: Implement edit profile
                        },
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                ),
              ),

              // Appearance Settings
              SettingsSection(
                title: 'Appearance',
                icon: Icons.palette,
                children: [
                  ListTile(
                    title: const Text('Theme'),
                    subtitle: Text(prefs.themeMode.name),
                    leading: const Icon(Icons.dark_mode),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text('Choose Theme'),
                          children: ThemeMode.values.map((mode) {
                            return RadioListTile<ThemeMode>(
                              title: Text(mode.name),
                              value: mode,
                              groupValue: prefs.themeMode,
                              onChanged: (value) {
                                Navigator.pop(context);
                                if (value != null) {
                                  settingsProvider.setThemeMode(value);
                                }
                              },
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Text Size'),
                    subtitle: Text('${(prefs.textScale * 100).round()}%'),
                    leading: const Icon(Icons.text_fields),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Adjust Text Size'),
                          content: StatefulBuilder(
                            builder: (context, setState) => Slider(
                              value: prefs.textScale,
                              min: 0.8,
                              max: 1.4,
                              divisions: 6,
                              label:
                                  '${(prefs.textScale * 100).round()}%',
                              onChanged: (value) {
                                setState(() {
                                  settingsProvider.setTextScale(value);
                                });
                              },
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Done'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Language'),
                    subtitle: Text(prefs.language),
                    leading: const Icon(Icons.language),
                    onTap: () {
                      // TODO: Implement language selection
                    },
                  ),
                ],
              ),

              // Cultural Preferences
              SettingsSection(
                title: 'Cultural Preferences',
                icon: Icons.diversity_3,
                children: [
                  CulturalPreferencesSection(
                    selectedPreferences: prefs.culturalPreferences,
                    selectedFestivals: prefs.festivals,
                    onPreferencesChanged: settingsProvider.updateCulturalPreferences,
                    onFestivalsChanged: settingsProvider.updateFestivals,
                  ),
                ],
              ),

              // Astrological Preferences
              SettingsSection(
                title: 'Astrological Preferences',
                icon: Icons.auto_awesome,
                children: [
                  AstrologicalPreferencesSection(
                    userZodiacSign: prefs.userZodiacSign,
                    partnerZodiacSign: prefs.partnerZodiacSign,
                    considerPlanetaryAlignments: prefs.considerPlanetaryAlignments,
                    considerMoonPhases: prefs.considerMoonPhases,
                    excludeInauspiciousDates: prefs.excludeInauspiciousDates,
                    onUserZodiacChanged: (sign) => settingsProvider.setZodiacSigns(sign, prefs.partnerZodiacSign),
                    onPartnerZodiacChanged: (sign) => settingsProvider.setZodiacSigns(prefs.userZodiacSign, sign),
                    onPlanetaryAlignmentsChanged: (value) => settingsProvider.toggleAstrologicalPreferences(planetaryAlignments: value),
                    onMoonPhasesChanged: (value) => settingsProvider.toggleAstrologicalPreferences(moonPhases: value),
                    onExcludeInauspiciousChanged: (value) => settingsProvider.toggleAstrologicalPreferences(excludeInauspicious: value),
                  ),
                ],
              ),

              // Event Preferences
              SettingsSection(
                title: 'Event Preferences',
                icon: Icons.event,
                children: [
                  EventPreferencesSection(
                    selectedEventTypes: prefs.selectedEventTypes,
                    customEventType: prefs.customEventType,
                    preferredTiming: prefs.preferredTiming,
                    preferredSeason: prefs.preferredSeason,
                    onEventTypesChanged: settingsProvider.updateEventTypes,
                    onCustomEventTypeChanged: (type) => settingsProvider.updateEventTypes(prefs.selectedEventTypes, customType: type),
                    onPreferredTimingChanged: (timing) => settingsProvider.updateEventPreferences(timing: timing),
                    onPreferredSeasonChanged: (season) => settingsProvider.updateEventPreferences(season: season),
                  ),
                ],
              ),

              // Notification Settings
              SettingsSection(
                title: 'Notifications',
                icon: Icons.notifications,
                children: [
                  SwitchListTile(
                    title: const Text('Push Notifications'),
                    subtitle: const Text('Receive notifications on your device'),
                    value: prefs.pushNotificationsEnabled,
                    onChanged: settingsProvider.togglePushNotifications,
                  ),
                  SwitchListTile(
                    title: const Text('Email Notifications'),
                    subtitle: const Text('Receive notifications via email'),
                    value: prefs.emailNotificationsEnabled,
                    onChanged: settingsProvider.toggleEmailNotifications,
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Notification Types'),
                    subtitle: const Text('Customize what notifications you receive'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Implement notification types screen
                    },
                  ),
                ],
              ),

              // Privacy & Security
              SettingsSection(
                title: 'Privacy & Security',
                icon: Icons.security,
                children: [
                  SwitchListTile(
                    title: const Text('Two-Factor Authentication'),
                    subtitle: const Text('Add an extra layer of security'),
                    value: prefs.twoFactorEnabled,
                    onChanged: settingsProvider.toggleTwoFactor,
                  ),
                  ListTile(
                    title: const Text('Change Password'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Implement change password
                    },
                  ),
                  ListTile(
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Show privacy policy
                    },
                  ),
                ],
              ),

              // Support & About
              SettingsSection(
                title: 'Support & About',
                icon: Icons.help,
                children: [
                  ListTile(
                    title: const Text('Help Center'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Open help center
                    },
                  ),
                  ListTile(
                    title: const Text('Contact Support'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Open contact support
                    },
                  ),
                  ListTile(
                    title: const Text('About'),
                    subtitle: const Text('Version 1.0.0'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Show about dialog
                    },
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
