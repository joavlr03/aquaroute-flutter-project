import '/models/models.dart';

class MockData {
  // ─── Rivers ──────────────────────────────────────────────────────────────
  static List<River> rivers = [
    River(
      id: 'negro',
      name: 'Rio Negro',
      level: 8.2,
      temperature: 27.3,
      riskLevel: 'BAIXA',
      status: 'Navegável',
      isFavorite: true,
    ),
    River(
      id: 'solimoes',
      name: 'Rio Solimões',
      level: 7.8,
      temperature: 28.1,
      riskLevel: 'MEDIA',
      status: 'Atenção',
    ),
    River(
      id: 'madeira',
      name: 'Rio Madeira',
      level: 9.1,
      temperature: 26.8,
      riskLevel: 'ALTA',
      status: 'Risco Alto',
    ),
    River(
      id: 'tapajos',
      name: 'Rio Tapajós',
      level: 5.4,
      temperature: 29.2,
      riskLevel: 'BAIXA',
      status: 'Navegável',
    ),
    River(
      id: 'xingu',
      name: 'Rio Xingu',
      level: 6.7,
      temperature: 28.7,
      riskLevel: 'MEDIA',
      status: 'Atenção',
    ),
    River(
      id: 'amazon',
      name: 'Rio Amazonas',
      level: 11.3,
      temperature: 26.4,
      riskLevel: 'CRÍTICA',
      status: 'Crítico',
    ),
  ];

  // ─── Alerts ──────────────────────────────────────────────────────────────
  static List<RiverAlert> alerts = [
    RiverAlert(
      id: 'a1',
      title: 'Nível Crítico',
      description: 'Rio Madeira atingiu 96% do nível crítico. Evite trechos entre km 40-80.',
      riverId: 'madeira',
      riverName: 'Rio Madeira',
      severity: 'CRÍTICA',
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      type: 'NIVEL',
    ),
    RiverAlert(
      id: 'a2',
      title: 'Tempestade Intensa',
      description: 'Chuvas fortes previstas para as próximas 6h na região da Amazônia Central.',
      riverId: 'solimoes',
      riverName: 'Rio Solimões',
      severity: 'ALTA',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      type: 'TEMPESTADE',
    ),
    RiverAlert(
      id: 'a3',
      title: 'Trecho Interditado',
      description: 'Visibilidade reduzida no Rio Madeira entre Humaitá e Manicoré. Aguardar.',
      riverId: 'madeira',
      riverName: 'Rio Madeira',
      severity: 'ALTA',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      type: 'TRECHO',
    ),
    RiverAlert(
      id: 'a4',
      title: 'Nível Abaixo da Média',
      description: 'Rio Tapajós com vazão abaixo da média sazonal. Atenção ao calado.',
      riverId: 'tapajos',
      riverName: 'Rio Tapajós',
      severity: 'MEDIA',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      type: 'NIVEL',
    ),
    RiverAlert(
      id: 'a5',
      title: 'Área de Corredeiras',
      description: 'Área de corredeiras identificada no Rio Xingu. Navegação técnica recomendada.',
      riverId: 'xingu',
      riverName: 'Rio Xingu',
      severity: 'BAIXA',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      type: 'TRECHO',
    ),
    RiverAlert(
      id: 'a6',
      title: 'Corrente Forte',
      description: 'Corrente acima de 4 nós no trecho Manaus-Itacoatiara. Recomenda-se embarcações de maior porte.',
      riverId: 'amazon',
      riverName: 'Rio Amazonas',
      severity: 'ALTA',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      type: 'CORRENTE',
    ),
  ];

  // ─── Routes ──────────────────────────────────────────────────────────────
  static List<AquaRoute> getRoutes(String origin, String destination) {
    return [
      AquaRoute(
        id: 'r1',
        origin: origin,
        destination: destination,
        distanceKm: 312.0,
        durationMinutes: 480,
        riskLevel: 'ALTA',
        fuelLiters: 280,
        fuelCostBrl: 1540.0,
        type: RouteType.fastest,
        river: 'Rio Solimões',
        alerts: ['Tempestade prevista', 'Corrente forte'],
        description: 'Rota direta pelo canal principal. Menor distância, porém com alertas ativos.',
        waypoints: [
          RouteWaypoint(name: origin, type: 'PORTO'),
          RouteWaypoint(name: 'Porto Coari', type: 'PORTO'),
          RouteWaypoint(name: 'Comunidade Juruá', type: 'COMUNIDADE'),
          RouteWaypoint(name: destination, type: 'PORTO'),
        ],
      ),
      AquaRoute(
        id: 'r2',
        origin: origin,
        destination: destination,
        distanceKm: 387.0,
        durationMinutes: 620,
        riskLevel: 'BAIXA',
        fuelLiters: 320,
        fuelCostBrl: 1760.0,
        type: RouteType.safest,
        river: 'Rio Negro → Solimões',
        alerts: [],
        description: 'Rota pelo canal secundário do Rio Negro. Sem alertas ativos, condições estáveis.',
        waypoints: [
          RouteWaypoint(name: origin, type: 'PORTO'),
          RouteWaypoint(name: 'Porto Barcelos', type: 'PORTO'),
          RouteWaypoint(name: 'Posto Carvoeiro', type: 'POSTO_COMBUSTIVEL'),
          RouteWaypoint(name: 'Comunidade Moura', type: 'COMUNIDADE'),
          RouteWaypoint(name: destination, type: 'PORTO'),
        ],
      ),
      AquaRoute(
        id: 'r3',
        origin: origin,
        destination: destination,
        distanceKm: 298.0,
        durationMinutes: 540,
        riskLevel: 'MEDIA',
        fuelLiters: 210,
        fuelCostBrl: 1155.0,
        type: RouteType.economical,
        river: 'Rio Amazonas',
        alerts: ['Nível acima do normal'],
        description: 'Rota aproveitando a correnteza favorável. Menor consumo de combustível.',
        waypoints: [
          RouteWaypoint(name: origin, type: 'PORTO'),
          RouteWaypoint(name: 'Posto Manacapuru', type: 'POSTO_COMBUSTIVEL'),
          RouteWaypoint(name: 'Porto Itacoatiara', type: 'PORTO'),
          RouteWaypoint(name: destination, type: 'PORTO'),
        ],
      ),
    ];
  }

  // ─── Ports / Locations ───────────────────────────────────────────────────
  static const List<String> locations = [
    'Manaus - AM',
    'Belém - PA',
    'Santarém - PA',
    'Itacoatiara - AM',
    'Parintins - AM',
    'Tefé - AM',
    'Coari - AM',
    'Manacapuru - AM',
    'Maués - AM',
    'Óbidos - PA',
    'Oriximiná - PA',
    'Porto Velho - RO',
    'Humaitá - AM',
    'Tabatinga - AM',
    'Altamira - PA',
  ];

  // ─── Weather ─────────────────────────────────────────────────────────────
  static List<WeatherDay> weather = [
    WeatherDay(dayLabel: 'Hoje', condition: 'Chuva Forte', maxTemp: 31.0, minTemp: 24.0, precipitationMm: 18.0, icon: '⛈️'),
    WeatherDay(dayLabel: 'Sáb', condition: 'Nublado', maxTemp: 30.0, minTemp: 23.5, precipitationMm: 8.0, icon: '🌧️'),
    WeatherDay(dayLabel: 'Dom', condition: 'Parcial', maxTemp: 32.0, minTemp: 24.0, precipitationMm: 3.0, icon: '⛅'),
    WeatherDay(dayLabel: 'Seg', condition: 'Ensolarado', maxTemp: 33.5, minTemp: 25.0, precipitationMm: 0.0, icon: '☀️'),
    WeatherDay(dayLabel: 'Ter', condition: 'Ensolarado', maxTemp: 34.0, minTemp: 25.5, precipitationMm: 0.0, icon: '☀️'),
    WeatherDay(dayLabel: 'Qua', condition: 'Nublado', maxTemp: 31.0, minTemp: 24.0, precipitationMm: 5.0, icon: '🌥️'),
    WeatherDay(dayLabel: 'Qui', condition: 'Chuva', maxTemp: 29.5, minTemp: 23.0, precipitationMm: 14.0, icon: '🌧️'),
  ];
}
