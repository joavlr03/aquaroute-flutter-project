import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rivers = MockData.rivers;
    final alerts = MockData.alerts.take(3).toList();
    final criticalCount = alerts.where((a) => a.severity == 'CRÍTICA' || a.severity == 'ALTA').length;
    final navigableCount = rivers.where((r) => r.riskLevel == 'BAIXA').length;

    return Scaffold(
      backgroundColor: AquaTheme.deepNavy,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bom dia, Capitão 👋',
                              style: TextStyle(color: AquaTheme.textMuted, fontSize: 13),
                            ),
                            const SizedBox(height: 2),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Aqua',
                                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
                                  ),
                                  TextSpan(
                                    text: 'Route',
                                    style: TextStyle(color: AquaTheme.aquaGreen, fontSize: 24, fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AquaTheme.navyBlue,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF1E3050)),
                          ),
                          child: const Icon(Icons.satellite_alt, color: AquaTheme.aquaGreen, size: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Stats row
                    Row(
                      children: [
                        StatCard(
                          value: '${rivers.length}',
                          label: 'Rios\nMonitorados',
                          color: AquaTheme.aquaGreen,
                        ),
                        const SizedBox(width: 10),
                        StatCard(
                          value: '$criticalCount',
                          label: 'Alertas\nAtivos',
                          color: AquaTheme.dangerRed,
                        ),
                        const SizedBox(width: 10),
                        StatCard(
                          value: '$navigableCount',
                          label: 'Trechos\nSeguras',
                          color: AquaTheme.safeGreen,
                        ),
                        const SizedBox(width: 10),
                        StatCard(
                          value: '7d',
                          label: 'Previsão\nDisponível',
                          color: AquaTheme.riverBlue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Plan route CTA
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/routes'),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AquaTheme.aquaGreen.withValues(alpha: 0.2),
                              AquaTheme.riverBlue.withValues(alpha: 0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AquaTheme.aquaGreen.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AquaTheme.aquaGreen.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.route, color: AquaTheme.aquaGreen, size: 24),
                            ),
                            const SizedBox(width: 14),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Planejar Nova Rota',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Encontre a melhor rota fluvial',
                                    style: TextStyle(color: AquaTheme.textMuted, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios, color: AquaTheme.aquaGreen, size: 16),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 200.ms)
                        .slideY(begin: 0.1, end: 0),
                  ],
                ),
              ),
            ),

            // Alerts section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: SectionHeader(
                  title: 'Alertas Recentes',
                  actionLabel: 'Ver todos',
                  onAction: () => Navigator.pushNamed(context, '/alerts'),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => AlertCard(alert: alerts[i])
                      .animate()
                      .fadeIn(delay: Duration(milliseconds: 100 * i)),
                  childCount: alerts.length,
                ),
              ),
            ),

            // Rivers section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: SectionHeader(
                  title: 'Rios Amazônicos',
                  actionLabel: 'Explorar',
                  onAction: () => Navigator.pushNamed(context, '/rivers'),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => RiverCard(
                    river: rivers[i],
                    onTap: () => Navigator.pushNamed(context, '/rivers'),
                  ).animate().fadeIn(delay: Duration(milliseconds: 80 * i)),
                  childCount: rivers.take(4).length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
