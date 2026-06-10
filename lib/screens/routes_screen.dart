import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  String? _origin;
  String? _destination;
  List<AquaRoute>? _routes;
  bool _loading = false;

  void _searchRoutes() async {
    if (_origin == null || _destination == null) return;
    if (_origin == _destination) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Origem e destino não podem ser iguais.'),
          backgroundColor: AquaTheme.dangerRed,
        ),
      );
      return;
    }
    setState(() {
      _loading = true;
      _routes = null;
    });
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _loading = false;
      _routes = MockData.getRoutes(_origin!, _destination!);
    });
  }

  Widget _buildLocationPicker(String label, String? value, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: AquaTheme.navyBlue,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1E3050)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(label, style: const TextStyle(color: AquaTheme.textMuted, fontSize: 14)),
          isExpanded: true,
          dropdownColor: const Color(0xFF0D2137),
          icon: const Icon(Icons.keyboard_arrow_down, color: AquaTheme.textMuted),
          items: MockData.locations.map((loc) {
            return DropdownMenuItem(
              value: loc,
              child: Text(loc, style: const TextStyle(color: Colors.white, fontSize: 14)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AquaTheme.deepNavy,
      appBar: AppBar(
        title: const Text('Planejar Rota', style: TextStyle(fontWeight: FontWeight.w700)),
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
            // Route planner card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AquaTheme.navyBlue,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF1E3050)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'De onde para onde?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Selecione origem e destino para calcular as melhores rotas.',
                    style: TextStyle(color: AquaTheme.textMuted, fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  // Origin
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AquaTheme.aquaGreen.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.circle, color: AquaTheme.aquaGreen, size: 12),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildLocationPicker(
                          'Selecione a origem',
                          _origin,
                          (v) => setState(() => _origin = v),
                        ),
                      ),
                    ],
                  ),
                  // Connector line
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      children: List.generate(
                        3,
                        (_) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          width: 2,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AquaTheme.textMuted.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Destination
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AquaTheme.dangerRed.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.location_on, color: AquaTheme.dangerRed, size: 16),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildLocationPicker(
                          'Selecione o destino',
                          _destination,
                          (v) => setState(() => _destination = v),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Search button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: (_origin != null && _destination != null) ? _searchRoutes : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AquaTheme.aquaGreen,
                        foregroundColor: AquaTheme.deepNavy,
                        disabledBackgroundColor: AquaTheme.aquaGreen.withValues(alpha: 0.3),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      icon: const Icon(Icons.search, size: 20),
                      label: const Text(
                        'Calcular Rotas',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Loading
            if (_loading) ...[
              const SizedBox(height: 40),
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(color: AquaTheme.aquaGreen, strokeWidth: 2),
                    SizedBox(height: 16),
                    Text(
                      'Consultando dados satelitais...',
                      style: TextStyle(color: AquaTheme.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],

            // Results
            if (_routes != null) ...[
              const SizedBox(height: 24),
              const SectionHeader(title: 'Rotas Disponíveis'),
              const SizedBox(height: 8),
              const Text(
                'Selecione a rota mais adequada à sua viagem.',
                style: TextStyle(color: AquaTheme.textMuted, fontSize: 12),
              ),
              const SizedBox(height: 12),
              ..._routes!.asMap().entries.map(
                    (e) => _RouteCard(route: e.value)
                        .animate()
                        .fadeIn(delay: Duration(milliseconds: 100 * e.key))
                        .slideY(begin: 0.1, end: 0),
                  ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RouteCard extends StatefulWidget {
  final AquaRoute route;
  const _RouteCard({required this.route});

  @override
  State<_RouteCard> createState() => _RouteCardState();
}

class _RouteCardState extends State<_RouteCard> {
  bool _expanded = false;

  Color get _typeColor {
    switch (widget.route.type) {
      case RouteType.fastest:
        return AquaTheme.riverBlue;
      case RouteType.safest:
        return AquaTheme.safeGreen;
      case RouteType.economical:
        return AquaTheme.warningAmber;
    }
  }

  IconData get _typeIcon {
    switch (widget.route.type) {
      case RouteType.fastest:
        return Icons.flash_on_outlined;
      case RouteType.safest:
        return Icons.shield_outlined;
      case RouteType.economical:
        return Icons.eco_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final route = widget.route;
    final riskColor = AquaTheme.riskColor(route.riskLevel);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AquaTheme.navyBlue,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _expanded ? _typeColor.withValues(alpha: 0.4) : const Color(0xFF1E3050),
          width: _expanded ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: _typeColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(_typeIcon, color: _typeColor, size: 14),
                            const SizedBox(width: 5),
                            Text(
                              route.typeLabel,
                              style: TextStyle(
                                color: _typeColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      RiskBadge(risk: route.riskLevel, small: true),
                      const SizedBox(width: 8),
                      Icon(
                        _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: AquaTheme.textMuted,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Metrics row
                  Row(
                    children: [
                      _Metric(
                        icon: Icons.straighten_outlined,
                        label: 'Distância',
                        value: '${route.distanceKm.toStringAsFixed(0)} km',
                        color: Colors.white,
                      ),
                      _Metric(
                        icon: Icons.access_time_outlined,
                        label: 'Duração',
                        value: route.durationLabel,
                        color: Colors.white,
                      ),
                      _Metric(
                        icon: Icons.local_gas_station_outlined,
                        label: 'Combustível',
                        value: 'R\$ ${route.fuelCostBrl.toStringAsFixed(0)}',
                        color: AquaTheme.warningAmber,
                      ),
                      _Metric(
                        icon: Icons.shield_outlined,
                        label: 'Risco',
                        value: route.riskLevel,
                        color: riskColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Expanded details
          if (_expanded) ...[
            Container(height: 1, color: const Color(0xFF1E3050)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Text(
                    route.description,
                    style: const TextStyle(color: AquaTheme.textMuted, fontSize: 13, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  // River
                  _DetailRow(icon: Icons.water_outlined, label: 'Rio', value: route.river),
                  const SizedBox(height: 8),
                  _DetailRow(
                    icon: Icons.local_gas_station_outlined,
                    label: 'Combustível',
                    value: '${route.fuelLiters.toStringAsFixed(0)}L  ·  R\$ ${route.fuelCostBrl.toStringAsFixed(0)}',
                  ),
                  // Alerts
                  if (route.alerts.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Text(
                      'Alertas nesta rota',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    ...route.alerts.map(
                      (a) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber_outlined, color: AquaTheme.warningAmber, size: 14),
                            const SizedBox(width: 8),
                            Text(a, style: const TextStyle(color: AquaTheme.textMuted, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ],
                  // Waypoints
                  const SizedBox(height: 12),
                  const Text(
                    'Pontos de parada',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  ...route.waypoints.asMap().entries.map((e) => _WaypointTile(
                        waypoint: e.value,
                        isFirst: e.key == 0,
                        isLast: e.key == route.waypoints.length - 1,
                      )),
                  const SizedBox(height: 16),
                  // Select button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Rota ${route.typeLabel} selecionada!'),
                            backgroundColor: AquaTheme.safeGreen,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _typeColor,
                        foregroundColor: AquaTheme.deepNavy,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'Usar esta rota',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _Metric({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AquaTheme.textMuted, size: 16),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12)),
          Text(label, style: const TextStyle(color: AquaTheme.textMuted, fontSize: 10)),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AquaTheme.aquaGreen, size: 16),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(color: AquaTheme.textMuted, fontSize: 13)),
        Expanded(
          child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}

class _WaypointTile extends StatelessWidget {
  final RouteWaypoint waypoint;
  final bool isFirst;
  final bool isLast;
  const _WaypointTile({required this.waypoint, required this.isFirst, required this.isLast});

  Color get _dotColor {
    if (isFirst) return AquaTheme.aquaGreen;
    if (isLast) return AquaTheme.dangerRed;
    if (waypoint.type == 'POSTO_COMBUSTIVEL') return AquaTheme.warningAmber;
    return AquaTheme.textMuted;
  }

  IconData get _icon {
    switch (waypoint.type) {
      case 'PORTO':
        return Icons.anchor;
      case 'POSTO_COMBUSTIVEL':
        return Icons.local_gas_station;
      case 'COMUNIDADE':
        return Icons.people_outline;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: _dotColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(color: _dotColor.withValues(alpha: 0.4)),
              ),
              child: Icon(_icon, color: _dotColor, size: 14),
            ),
            if (!isLast)
              Container(
                width: 1.5,
                height: 16,
                margin: const EdgeInsets.symmetric(vertical: 2),
                color: const Color(0xFF2A4060),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                waypoint.name,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
              ),
              Text(
                waypoint.type.replaceAll('_', ' '),
                style: const TextStyle(color: AquaTheme.textMuted, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
