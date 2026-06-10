import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/main_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AquaTheme.navyBlue,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const AquaRouteApp());
}

class AquaRouteApp extends StatelessWidget {
  const AquaRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaRoute',
      debugShowCheckedModeBanner: false,
      theme: AquaTheme.theme,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/intro': (_) => const IntroScreen(),
        '/home': (_) => const MainShell(),
        '/rivers': (_) => const MainShell(),
        '/alerts': (_) => const MainShell(),
        '/routes': (_) => const MainShell(),
      },
    );
  }
}