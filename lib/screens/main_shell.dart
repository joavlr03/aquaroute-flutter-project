import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'rivers_screen.dart';
import 'alerts_screen.dart';
import 'routes_screen.dart';
import 'weather_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final _screens = const [
    HomeScreen(),
    RiversScreen(),
    AlertsScreen(),
    RoutesScreen(),
    WeatherScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AquaTheme.navyBlue,
          border: Border(top: BorderSide(color: Color(0xFF1E3050))),
        ),
        child: NavigationBar(
          backgroundColor: AquaTheme.navyBlue,
          selectedIndex: _currentIndex,
          onDestinationSelected: (i) => setState(() => _currentIndex = i),
          indicatorColor: AquaTheme.aquaGreen.withValues(alpha: 0.15),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Color(0xFF4A6080)),
              selectedIcon: Icon(Icons.home, color: AquaTheme.aquaGreen),
              label: 'Início',
            ),
            NavigationDestination(
              icon: Icon(Icons.water_outlined, color: Color(0xFF4A6080)),
              selectedIcon: Icon(Icons.water, color: AquaTheme.aquaGreen),
              label: 'Rios',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined, color: Color(0xFF4A6080)),
              selectedIcon: Icon(Icons.notifications, color: AquaTheme.aquaGreen),
              label: 'Alertas',
            ),
            NavigationDestination(
              icon: Icon(Icons.route_outlined, color: Color(0xFF4A6080)),
              selectedIcon: Icon(Icons.route, color: AquaTheme.aquaGreen),
              label: 'Rotas',
            ),
            NavigationDestination(
              icon: Icon(Icons.wb_sunny_outlined, color: Color(0xFF4A6080)),
              selectedIcon: Icon(Icons.wb_sunny, color: AquaTheme.aquaGreen),
              label: 'Tempo',
            ),
          ],
        ),
      ),
    );
  }
}
