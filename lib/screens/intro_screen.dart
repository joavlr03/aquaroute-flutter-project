import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentPage = 0;
  final PageController _controller = PageController();

  final List<_IntroPage> _pages = [
    _IntroPage(
      icon: Icons.satellite_alt_outlined,
      iconColor: AquaTheme.aquaGreen,
      title: 'Dados do Espaço,\nna sua mão.',
      description:
          'O AquaRoute integra satélites da NASA e ESA com sensores hidrológicos da ANA para entregar informações em tempo real sobre os rios da Amazônia.',
      tag: 'TECNOLOGIA ORBITAL',
    ),
    _IntroPage(
      icon: Icons.route_outlined,
      iconColor: AquaTheme.riverBlue,
      title: 'Navegue com\ninteligência.',
      description:
          'Calcule rotas fluviais otimizadas por segurança, velocidade ou economia. Nosso algoritmo analisa nível, corrente e clima para sugerir o melhor caminho.',
      tag: 'ROTEIRIZAÇÃO IA',
    ),
    _IntroPage(
      icon: Icons.notifications_active_outlined,
      iconColor: AquaTheme.warningAmber,
      title: 'Alertas antes\ndo perigo.',
      description:
          'Receba notificações sobre cheias, tempestades e trechos de risco antes de zarpar. 25 milhões de amazônidas dependem de informação — agora ela chegou.',
      tag: 'ALERTAS EM TEMPO REAL',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _back() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentPage == _pages.length - 1;
    return Scaffold(
      backgroundColor: AquaTheme.deepNavy,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                child: const Text(
                  'Pular',
                  style: TextStyle(color: AquaTheme.textMuted, fontSize: 14),
                ),
              ),
            ),
            // Pages
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) => _PageContent(page: _pages[i]),
              ),
            ),
            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? AquaTheme.aquaGreen
                        : AquaTheme.textMuted.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _back,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AquaTheme.aquaGreen,
                          side: const BorderSide(color: AquaTheme.aquaGreen),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text('Voltar'),
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AquaTheme.aquaGreen,
                        foregroundColor: AquaTheme.deepNavy,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        isLast ? 'Começar' : 'Avançar',
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _IntroPage {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String tag;

  _IntroPage({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.tag,
  });
}

class _PageContent extends StatelessWidget {
  final _IntroPage page;
  const _PageContent({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon in glowing circle
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: page.iconColor.withValues(alpha: 0.1),
              border: Border.all(color: page.iconColor.withValues(alpha: 0.3), width: 2),
            ),
            child: Icon(page.icon, size: 60, color: page.iconColor),
          )
              .animate()
              .scale(duration: 500.ms, curve: Curves.elasticOut),
          const SizedBox(height: 32),
          // Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: page.iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: page.iconColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              page.tag,
              style: TextStyle(
                color: page.iconColor,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          )
              .animate()
              .fadeIn(delay: 100.ms),
          const SizedBox(height: 20),
          // Title
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          )
              .animate()
              .fadeIn(delay: 200.ms)
              .slideY(begin: 0.2, end: 0),
          const SizedBox(height: 16),
          // Description
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AquaTheme.textMuted,
              fontSize: 14,
              height: 1.6,
            ),
          )
              .animate()
              .fadeIn(delay: 300.ms),
        ],
      ),
    );
  }
}
