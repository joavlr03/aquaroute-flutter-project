import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class RiversScreen extends StatefulWidget {
  const RiversScreen({super.key});

  @override
  State<RiversScreen> createState() => _RiversScreenState();
}

class _RiversScreenState extends State<RiversScreen> {
  String _filter = 'TODOS';
  List<River> _rivers = [];

  final filters = ['TODOS', 'BAIXA', 'MEDIA', 'ALTA', 'CRÍTICA'];

  @override
  void initState() {
    super.initState();
    _rivers = List.from(MockData.rivers);
  }

  List<River> get _filtered {
    if (_filter == 'TODOS') return _rivers;
    return _rivers.where((r) => r.riskLevel == _filter).toList();
  }

  void _toggleFavorite(River river) {
    setState(() {
      final idx = _rivers.indexWhere((r) => r.id == river.id);
      if (idx != -1) {
        _rivers[idx] = _rivers[idx].copyWith(isFavorite: !_rivers[idx].isFavorite);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AquaTheme.deepNavy,
      appBar: AppBar(
        title: const Text('Rios Amazônicos', style: TextStyle(fontWeight: FontWeight.w700)),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.pop(context),
              )
            : null,
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
              separatorBuilder: (_,__) => const SizedBox(width: 8),
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
          // Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${_filtered.length} rio${_filtered.length != 1 ? 's' : ''}',
                style: const TextStyle(color: AquaTheme.textMuted, fontSize: 12),
              ),
            ),
          ),
          // List
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum rio com esse filtro.',
                      style: TextStyle(color: AquaTheme.textMuted),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) {
                      final river = _filtered[i];
                      return _RiverDetailCard(
                        river: river,
                        onFavorite: () => _toggleFavorite(river),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _RiverDetailCard extends StatelessWidget {
  final River river;
  final VoidCallback onFavorite;
  const _RiverDetailCard({required this.river, required this.onFavorite});

  @override
  Widget build(BuildContext context) {
    final riskColor = AquaTheme.riskColor(river.riskLevel);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AquaTheme.navyBlue,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E3050)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        river.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        river.status,
                        style: TextStyle(color: riskColor, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onFavorite,
                  icon: Icon(
                    river.isFavorite ? Icons.star : Icons.star_border,
                    color: river.isFavorite ? AquaTheme.warningAmber : AquaTheme.textMuted,
                  ),
                ),
                RiskBadge(risk: river.riskLevel),
              ],
            ),
          ),
          // Divider
          Container(height: 1, color: const Color(0xFF1E3050)),
          // Data row
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _DataChip(icon: Icons.water_drop_outlined, label: 'Nível', value: '${river.level}m'),
                const SizedBox(width: 12),
                _DataChip(icon: Icons.thermostat_outlined, label: 'Temp.', value: '${river.temperature}°C'),
                const SizedBox(width: 12),
                _DataChip(
                  icon: Icons.shield_outlined,
                  label: 'Risco',
                  value: river.riskLevel,
                  valueColor: riskColor,
                ),
              ],
            ),
          ),
          // Level bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nível atual', style: TextStyle(color: AquaTheme.textMuted, fontSize: 11)),
                    Text(
                      '${(river.level / 15 * 100).toStringAsFixed(0)}% do nível máximo',
                      style: const TextStyle(color: AquaTheme.textMuted, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: river.level / 15,
                    backgroundColor: const Color(0xFF1E3050),
                    valueColor: AlwaysStoppedAnimation<Color>(riskColor),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DataChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  const _DataChip({required this.icon, required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0A1628),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: AquaTheme.textMuted, size: 16),
            const SizedBox(height: 4),
            Text(value,
                style: TextStyle(
                  color: valueColor ?? Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                )),
            Text(label, style: const TextStyle(color: AquaTheme.textMuted, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
