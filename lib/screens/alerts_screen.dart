import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/widgets.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String _filter = 'TODOS';
  final filters = ['TODOS', 'BAIXA', 'MEDIA', 'ALTA', 'CRÍTICA'];

  @override
  Widget build(BuildContext context) {
    final allAlerts = MockData.alerts;
    final filtered = _filter == 'TODOS'
        ? allAlerts
        : allAlerts.where((a) => a.severity == _filter).toList();

    return Scaffold(
      backgroundColor: AquaTheme.deepNavy,
      appBar: AppBar(
        title: const Text('Alertas', style: TextStyle(fontWeight: FontWeight.w700)),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AquaTheme.dangerRed.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AquaTheme.dangerRed.withValues(alpha: 0.4)),
                ),
                child: Text(
                  '${allAlerts.length} ativos',
                  style: const TextStyle(
                    color: AquaTheme.dangerRed,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final f = filters[i];
                final selected = _filter == f;
                final color = f == 'TODOS' ? AquaTheme.aquaGreen : AquaTheme.riskColor(f);
                return FilterChip(
                  label: Text(f),
                  selected: selected,
                  onSelected: (_) => setState(() => _filter = f),
                  backgroundColor: const Color(0xFF142030),
                  selectedColor: color.withValues(alpha: 0.2),
                  labelStyle: TextStyle(
                    color: selected ? color : AquaTheme.textMuted,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                    fontSize: 12,
                  ),
                  side: BorderSide(
                    color: selected ? color.withValues(alpha: 0.6) : const Color(0xFF2A4060),
                  ),
                  showCheckmark: false,
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${filtered.length} alerta${filtered.length != 1 ? 's' : ''}',
                style: const TextStyle(color: AquaTheme.textMuted, fontSize: 12),
              ),
            ),
          ),
          // Alert list
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, color: AquaTheme.safeGreen, size: 48),
                        SizedBox(height: 12),
                        Text('Nenhum alerta nessa categoria.',
                            style: TextStyle(color: AquaTheme.textMuted)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    itemCount: filtered.length,
                    itemBuilder: (_, i) => AlertCard(alert: filtered[i]),
                  ),
          ),
        ],
      ),
    );
  }
}
