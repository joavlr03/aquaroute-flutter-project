// ─── River Model ───────────────────────────────────────────────────────────
class River {
  final String id;
  final String name;
  final double level; // meters
  final double temperature;
  final String riskLevel; // BAIXA, MEDIA, ALTA, CRITICA
  final String status;
  final bool isFavorite;

  River({
    required this.id,
    required this.name,
    required this.level,
    required this.temperature,
    required this.riskLevel,
    required this.status,
    this.isFavorite = false,
  });

  River copyWith({bool? isFavorite}) => River(
        id: id,
        name: name,
        level: level,
        temperature: temperature,
        riskLevel: riskLevel,
        status: status,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}

// ─── Alert Model ───────────────────────────────────────────────────────────
class RiverAlert {
  final String id;
  final String title;
  final String description;
  final String riverId;
  final String riverName;
  final String severity; // BAIXA, MEDIA, ALTA, CRITICA
  final DateTime createdAt;
  final String type; // NIVEL, TEMPESTADE, TRECHO, CORRENTE

  RiverAlert({
    required this.id,
    required this.title,
    required this.description,
    required this.riverId,
    required this.riverName,
    required this.severity,
    required this.createdAt,
    required this.type,
  });
}

// ─── Route Models ──────────────────────────────────────────────────────────
enum RouteType { fastest, safest, economical }

class RouteWaypoint {
  final String name;
  final String type; // PORTO, COMUNIDADE, POSTO_COMBUSTIVEL

  RouteWaypoint({required this.name, required this.type});
}

class AquaRoute {
  final String id;
  final String origin;
  final String destination;
  final double distanceKm;
  final int durationMinutes;
  final String riskLevel;
  final double fuelLiters;
  final double fuelCostBrl;
  final RouteType type;
  final List<RouteWaypoint> waypoints;
  final String river;
  final List<String> alerts;
  final String description;

  AquaRoute({
    required this.id,
    required this.origin,
    required this.destination,
    required this.distanceKm,
    required this.durationMinutes,
    required this.riskLevel,
    required this.fuelLiters,
    required this.fuelCostBrl,
    required this.type,
    required this.waypoints,
    required this.river,
    required this.alerts,
    required this.description,
  });

  String get durationLabel {
    final h = durationMinutes ~/ 60;
    final m = durationMinutes % 60;
    if (h == 0) return '${m}min';
    if (m == 0) return '${h}h';
    return '${h}h ${m}min';
  }

  String get typeLabel {
    switch (type) {
      case RouteType.fastest:
        return 'Mais Rápida';
      case RouteType.safest:
        return 'Mais Segura';
      case RouteType.economical:
        return 'Mais Econômica';
    }
  }
}

// ─── Weather Forecast ──────────────────────────────────────────────────────
class WeatherDay {
  final String dayLabel;
  final String condition;
  final double maxTemp;
  final double minTemp;
  final double precipitationMm;
  final String icon; // emoji

  WeatherDay({
    required this.dayLabel,
    required this.condition,
    required this.maxTemp,
    required this.minTemp,
    required this.precipitationMm,
    required this.icon,
  });
}
