import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';

// ─── Risk Badge ──────────────────────────────────────────────────────────────
class RiskBadge extends StatelessWidget {
  final String risk;
  final bool small;
  const RiskBadge({super.key, required this.risk, this.small = false});

  @override
  Widget build(BuildContext context) {
    final color = AquaTheme.riskColor(risk);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 10,
        vertical: small ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        risk,
        style: TextStyle(
          color: color,
          fontSize: small ? 10 : 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─── Section Header ──────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  const SectionHeader({super.key, required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: const TextStyle(
                color: AquaTheme.aquaGreen,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

// ─── River Card ──────────────────────────────────────────────────────────────
class RiverCard extends StatelessWidget {
  final River river;
  final VoidCallback? onTap;
  const RiverCard({super.key, required this.river, this.onTap});

  @override
  Widget build(BuildContext context) {
    final riskColor = AquaTheme.riskColor(river.riskLevel);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AquaTheme.navyBlue,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1E3050)),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 48,
              decoration: BoxDecoration(
                color: riskColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    river.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Nível: ${river.level}m  ·  ${river.temperature}°C',
                    style: const TextStyle(color: AquaTheme.textMuted, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            RiskBadge(risk: river.riskLevel),
          ],
        ),
      ),
    );
  }
}

// ─── Alert Card ──────────────────────────────────────────────────────────────
class AlertCard extends StatelessWidget {
  final RiverAlert alert;
  const AlertCard({super.key, required this.alert});

  IconData _icon() {
    switch (alert.type) {
      case 'TEMPESTADE':
        return Icons.thunderstorm_outlined;
      case 'NIVEL':
        return Icons.water_outlined;
      case 'TRECHO':
        return Icons.warning_amber_outlined;
      case 'CORRENTE':
        return Icons.waves_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  String _timeAgo() {
    final diff = DateTime.now().difference(alert.createdAt);
    if (diff.inMinutes < 60) return 'Há ${diff.inMinutes}min';
    if (diff.inHours < 24) return 'Há ${diff.inHours}h';
    return 'Há ${diff.inDays}d';
  }

  @override
  Widget build(BuildContext context) {
    final color = AquaTheme.riskColor(alert.severity);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AquaTheme.navyBlue,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E3050)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_icon(), color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        alert.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    RiskBadge(risk: alert.severity, small: true),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  alert.description,
                  style: const TextStyle(color: AquaTheme.textMuted, fontSize: 12, height: 1.4),
                ),
                const SizedBox(height: 6),
                Text(
                  '↑ ${alert.riverName}  ·  ${_timeAgo()}',
                  style: const TextStyle(
                    color: AquaTheme.aquaGreen,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
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

// ─── Stat Card ───────────────────────────────────────────────────────────────
class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const StatCard({super.key, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: AquaTheme.textMuted, fontSize: 11), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
