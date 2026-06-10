import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../models/models.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  int _selectedDay = 0;

  @override
  Widget build(BuildContext context) {
    final weather = MockData.weather;
    final selected = weather[_selectedDay];

    return Scaffold(
      backgroundColor: AquaTheme.deepNavy,
      appBar: AppBar(
        title: const Text('Previsão do Tempo', style: TextStyle(fontWeight: FontWeight.w700)),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current day hero
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AquaTheme.riverBlue.withValues(alpha: 0.4),
                    AquaTheme.deepNavy,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF1E3050)),
              ),
              child: Column(
                children: [
                  Text(selected.icon, style: const TextStyle(fontSize: 64))
                      .animate()
                      .scale(duration: 400.ms),
                  const SizedBox(height: 12),
                  Text(
                    selected.condition,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${selected.maxTemp.toStringAsFixed(1)}° / ${selected.minTemp.toStringAsFixed(1)}°C',
                    style: const TextStyle(color: AquaTheme.textMuted, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _WeatherMetric(
                        icon: '🌧️',
                        label: 'Precipitação',
                        value: '${selected.precipitationMm}mm',
                      ),
                      _WeatherMetric(
                        icon: '🌡️',
                        label: 'Máxima',
                        value: '${selected.maxTemp}°C',
                      ),
                      _WeatherMetric(
                        icon: '❄️',
                        label: 'Mínima',
                        value: '${selected.minTemp}°C',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Day selector
            const Text(
              'Próximos 7 dias',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: weather.length,
                separatorBuilder: (_, ___) => const SizedBox(width: 10),
                itemBuilder: (_, i) {
                  final day = weather[i];
                  final selected = _selectedDay == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedDay = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 68,
                      decoration: BoxDecoration(
                        color: selected ? AquaTheme.aquaGreen.withValues(alpha: 0.15) : AquaTheme.navyBlue,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: selected ? AquaTheme.aquaGreen.withValues(alpha: 0.5) : const Color(0xFF1E3050),
                          width: selected ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day.dayLabel,
                            style: TextStyle(
                              color: selected ? AquaTheme.aquaGreen : AquaTheme.textMuted,
                              fontSize: 11,
                              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(day.icon, style: const TextStyle(fontSize: 22)),
                          const SizedBox(height: 4),
                          Text(
                            '${day.maxTemp.toInt()}°',
                            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Navigation advisory
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AquaTheme.navyBlue,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF1E3050)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_outline, color: AquaTheme.aquaGreen, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Recomendação de Navegação',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _getAdvisory(selected),
                    style: const TextStyle(color: AquaTheme.textMuted, fontSize: 13, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getAdvisory(WeatherDay day) {
    if (day.precipitationMm >= 15) {
      return '⚠️ Precipitação intensa prevista. Evite navegação em trechos abertos. Aguarde a janela meteorológica melhorar.';
    } else if (day.precipitationMm >= 5) {
      return '🔶 Chuvas moderadas esperadas. Navegue com cautela e mantenha comunicação com a base.';
    } else {
      return '✅ Condições favoráveis para navegação. Verifique os alertas de nível dos rios antes de zarpar.';
    }
  }
}

class _WeatherMetric extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  const _WeatherMetric({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
        Text(label, style: const TextStyle(color: AquaTheme.textMuted, fontSize: 10)),
      ],
    );
  }
}
