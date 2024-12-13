import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'services/openai_service.dart';
import 'providers/theme_provider.dart';
import 'config/theme.dart';
import 'screens/settings_screen.dart';
import 'features/home/screens/home_screen.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env');

    final themeProvider = ThemeProvider();
    themeProvider.initialized;

    runApp(
      ChangeNotifierProvider.value(
        value: themeProvider,
        child: const WedWiseApp(),
      ),
    );
  } catch (e) {
    print('Error loading .env file: $e');
    runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const WedWiseApp(),
      ),
    );
  }
}

class WedWiseApp extends StatelessWidget {
  const WedWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => MaterialApp(
        title: 'WedWise',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeProvider.themeMode,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const Center(child: Text('Calendar')),
      const Center(child: Text('Notifications')),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
