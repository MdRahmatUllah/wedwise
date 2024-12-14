import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_preferences.dart';
import '../widgets/settings_section.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late UserPreferences _preferences;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Load preferences from storage and sync with ThemeProvider
    _preferences = UserPreferences();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      setState(() {
        _preferences =
            _preferences.copyWith(themeMode: themeProvider.themeMode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          if (_isSaving)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
        ],
      ),
      body: ListView(
        children: [
          SettingsSection(
            title: 'Appearance',
            icon: Icons.palette,
            children: [
              ListTile(
                title: const Text('Theme'),
                subtitle: Text(_getThemeText(_preferences.themeMode)),
                leading: const Icon(Icons.dark_mode),
                onTap: _showThemeDialog,
              ),
              ListTile(
                title: const Text('Language'),
                subtitle: Text(_preferences.language),
                leading: const Icon(Icons.language),
                onTap: _showLanguageDialog,
              ),
            ],
          ),
          SettingsSection(
            title: 'Notifications',
            icon: Icons.notifications,
            onMoreTap: () => _showNotificationSettings(),
            children: [
              SwitchListTile(
                title: const Text('Enable Notifications'),
                subtitle: const Text('Receive updates and reminders'),
                value: _preferences.notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _preferences = _preferences.copyWith(
                      notificationsEnabled: value,
                    );
                  });
                  _savePreferences();
                },
              ),
              if (_preferences.notificationsEnabled) ...[
                CheckboxListTile(
                  title: const Text('Reminders'),
                  value: _preferences.notificationTypes['reminders'],
                  onChanged: (value) =>
                      _updateNotificationType('reminders', value),
                ),
                CheckboxListTile(
                  title: const Text('Updates'),
                  value: _preferences.notificationTypes['updates'],
                  onChanged: (value) =>
                      _updateNotificationType('updates', value),
                ),
              ],
            ],
          ),
          SettingsSection(
            title: 'Display',
            icon: Icons.display_settings,
            children: [
              ListTile(
                title: const Text('Currency'),
                subtitle: Text(_preferences.currency),
                leading: const Icon(Icons.attach_money),
                onTap: _showCurrencyDialog,
              ),
              ListTile(
                title: const Text('Date Format'),
                subtitle: Text(_preferences.dateFormat),
                leading: const Icon(Icons.calendar_today),
                onTap: _showDateFormatDialog,
              ),
              ListTile(
                title: const Text('Time Format'),
                subtitle: Text(_preferences.timeFormat),
                leading: const Icon(Icons.access_time),
                onTap: _showTimeFormatDialog,
              ),
            ],
          ),
          SettingsSection(
            title: 'Home Screen',
            icon: Icons.home,
            children: [
              SwitchListTile(
                title: const Text('Show Budget'),
                subtitle: const Text('Display budget overview on home screen'),
                value: _preferences.showBudgetInHome,
                onChanged: (value) {
                  setState(() {
                    _preferences = _preferences.copyWith(
                      showBudgetInHome: value,
                    );
                  });
                  _savePreferences();
                },
              ),
              SwitchListTile(
                title: const Text('Show Timeline'),
                subtitle: const Text('Display timeline on home screen'),
                value: _preferences.showTimelineInHome,
                onChanged: (value) {
                  setState(() {
                    _preferences = _preferences.copyWith(
                      showTimelineInHome: value,
                    );
                  });
                  _savePreferences();
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'Privacy',
            icon: Icons.security,
            children: [
              SwitchListTile(
                title: const Text('Share Profile'),
                subtitle: const Text('Allow others to view your profile'),
                value: _preferences.privacySettings['shareProfile'] ?? false,
                onChanged: (value) =>
                    _updatePrivacySetting('shareProfile', value),
              ),
              SwitchListTile(
                title: const Text('Show Progress'),
                subtitle: const Text('Display planning progress publicly'),
                value: _preferences.privacySettings['showProgress'] ?? true,
                onChanged: (value) =>
                    _updatePrivacySetting('showProgress', value),
              ),
              SwitchListTile(
                title: const Text('Analytics'),
                subtitle: const Text('Help improve the app with usage data'),
                value: _preferences.privacySettings['allowAnalytics'] ?? true,
                onChanged: (value) =>
                    _updatePrivacySetting('allowAnalytics', value),
              ),
            ],
          ),
          SettingsSection(
            title: 'Cultural Preferences',
            icon: Icons.celebration,
            onMoreTap: () => _showCulturalPreferences(),
            children: [
              ListTile(
                title: const Text('Customize Cultural Settings'),
                subtitle: const Text('Set up traditions and customs'),
                leading: const Icon(Icons.diversity_3),
                onTap: _showCulturalPreferences,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                OutlinedButton.icon(
                  onPressed: _clearAllData,
                  icon: const Icon(Icons.delete_forever),
                  label: const Text('Clear All Data'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        // TODO: Implement help center
                      },
                      icon: const Icon(Icons.help_outline),
                      label: const Text('Help Center'),
                    ),
                    const SizedBox(width: 16),
                    TextButton.icon(
                      onPressed: () {
                        // TODO: Implement about
                      },
                      icon: const Icon(Icons.info_outline),
                      label: const Text('About'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Version 1.0.0',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  String _getThemeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System Default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  void _showThemeDialog() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose Theme'),
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('System Default'),
            value: ThemeMode.system,
            groupValue: _preferences.themeMode,
            onChanged: (value) {
              Navigator.pop(context);
              setState(() {
                _preferences = _preferences.copyWith(themeMode: value);
              });
              themeProvider.setThemeMode(value!);
              _savePreferences();
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: _preferences.themeMode,
            onChanged: (value) {
              Navigator.pop(context);
              setState(() {
                _preferences = _preferences.copyWith(themeMode: value);
              });
              themeProvider.setThemeMode(value!);
              _savePreferences();
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: _preferences.themeMode,
            onChanged: (value) {
              Navigator.pop(context);
              setState(() {
                _preferences = _preferences.copyWith(themeMode: value);
              });
              themeProvider.setThemeMode(value!);
              _savePreferences();
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    final languages = [
      'English',
      'Spanish',
      'French',
      'German',
      'Chinese',
      'Japanese'
    ];
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose Language'),
        children: languages
            .map((lang) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _preferences = _preferences.copyWith(language: lang);
                    });
                    _savePreferences();
                  },
                  child: Text(lang),
                ))
            .toList(),
      ),
    );
  }

  void _showNotificationSettings() {
    // TODO: Implement detailed notification settings
  }

  void _updateNotificationType(String type, bool? value) {
    if (value == null) return;
    setState(() {
      final newTypes = Map<String, bool>.from(_preferences.notificationTypes);
      newTypes[type] = value;
      _preferences = _preferences.copyWith(notificationTypes: newTypes);
    });
    _savePreferences();
  }

  void _showCurrencyDialog() {
    final currencies = ['USD', 'EUR', 'GBP', 'JPY', 'CNY', 'INR'];
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose Currency'),
        children: currencies
            .map((currency) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _preferences = _preferences.copyWith(currency: currency);
                    });
                    _savePreferences();
                  },
                  child: Text(currency),
                ))
            .toList(),
      ),
    );
  }

  void _showDateFormatDialog() {
    final formats = ['MM/dd/yyyy', 'dd/MM/yyyy', 'yyyy-MM-dd'];
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose Date Format'),
        children: formats
            .map((format) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _preferences = _preferences.copyWith(dateFormat: format);
                    });
                    _savePreferences();
                  },
                  child: Text(format),
                ))
            .toList(),
      ),
    );
  }

  void _showTimeFormatDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose Time Format'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _preferences = _preferences.copyWith(timeFormat: '12-hour');
              });
              _savePreferences();
            },
            child: const Text('12-hour (1:30 PM)'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _preferences = _preferences.copyWith(timeFormat: '24-hour');
              });
              _savePreferences();
            },
            child: const Text('24-hour (13:30)'),
          ),
        ],
      ),
    );
  }

  void _updatePrivacySetting(String setting, bool value) {
    setState(() {
      final newSettings = Map<String, bool>.from(_preferences.privacySettings);
      newSettings[setting] = value;
      _preferences = _preferences.copyWith(privacySettings: newSettings);
    });
    _savePreferences();
  }

  void _showCulturalPreferences() {
    // TODO: Implement cultural preferences screen
  }

  void _clearAllData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'Are you sure you want to clear all data? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement clear all data
              Navigator.pop(context);
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _savePreferences() async {
    setState(() {
      _isSaving = true;
    });

    // TODO: Save preferences to storage
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _isSaving = false;
    });
  }
}
