import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/intro');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AquaTheme.deepNavy,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AquaTheme.aquaGreen.withValues(alpha: 0.3),
                    AquaTheme.riverBlue.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
              child: const Icon(
                Icons.water,
                size: 64,
                color: AquaTheme.aquaGreen,
              ),
            )
                .animate()
                .scale(duration: 600.ms, curve: Curves.elasticOut)
                .fadeIn(duration: 400.ms),
            const SizedBox(height: 24),
            // App name
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Aqua',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  TextSpan(
                    text: 'Route',
                    style: TextStyle(
                      color: AquaTheme.aquaGreen,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(delay: 300.ms, duration: 500.ms)
                .slideY(begin: 0.2, end: 0),
            const SizedBox(height: 8),
            const Text(
              'LOGÍSTICA FLUVIAL AMAZÔNICA INTELIGENTE',
              style: TextStyle(
                color: AquaTheme.textMuted,
                fontSize: 10,
                letterSpacing: 2.5,
                fontWeight: FontWeight.w500,
              ),
            )
                .animate()
                .fadeIn(delay: 500.ms, duration: 500.ms),
            const SizedBox(height: 64),
            // Satellite data loading indicator
            Column(
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AquaTheme.aquaGreen,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Conectando aos satélites...',
                  style: TextStyle(color: AquaTheme.textMuted, fontSize: 12),
                ),
              ],
            )
                .animate()
                .fadeIn(delay: 800.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
}
