import 'package:flutter/material.dart';

import '../marco/marco_app.dart';

class HorariosScreen extends StatefulWidget {
  const HorariosScreen({super.key});

  @override
  State<HorariosScreen> createState() => _HorariosScreenState();
}

class _HorariosScreenState extends State<HorariosScreen> {
  final TextEditingController _controller = TextEditingController();
  _HorarioInfo? resultado;

  final Map<String, _HorarioInfo> horarios = {
    'la consolata': const _HorarioInfo(
      barrio: 'La Consolata',
      dias: 'Lunes, Miércoles y Viernes',
      hora: '7:00 PM',
      detalle: 'El camión pasa en la noche por este sector.',
    ),
    'ciudadela siglo xxi': const _HorarioInfo(
      barrio: 'Ciudadela Siglo XXI',
      dias: 'Lunes, Miércoles y Viernes',
      hora: '6:30 PM',
      detalle: 'Saca la basura 20 minutos antes.',
    ),
    'yapura sur': const _HorarioInfo(
      barrio: 'Yapura Sur',
      dias: 'Martes, Jueves y Sábado',
      hora: '8:00 AM',
      detalle: 'La recolección se hace en jornada de la mañana.',
    ),
    'acacias': const _HorarioInfo(
      barrio: 'Acacias',
      dias: 'Martes y Viernes',
      hora: '9:00 AM',
      detalle: 'Ruta compartida con barrios cercanos.',
    ),
  };

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _buscarHorario() {
    final query = _controller.text.trim().toLowerCase();
    setState(() {
      resultado = horarios[query];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MarcoApp(
      child: Scaffold(
        backgroundColor: const Color(0xFF2F7A72),
        body: SafeArea(
          child: Stack(
            children: [
              const Positioned(
                top: 68,
                left: -40,
                right: -40,
                child: _GlowCircle(),
              ),
              const Positioned(top: 24, right: 22, child: _LeafDecoration()),
              const Positioned(
                bottom: 130,
                left: -8,
                child: _LeafDecoration(flipped: true),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'HORARIOS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const Text(
                      'DE ATENCIÓN',
                      style: TextStyle(
                        color: Color(0xFFD4F0E2),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 34),
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 16,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Buscar barrio',
                            style: TextStyle(
                              color: Color(0xFF2F7A72),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _controller,
                            onSubmitted: (_) => _buscarHorario(),
                            decoration: InputDecoration(
                              hintText: 'Ej: La Consolata',
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: const Color(0xFFF3F6F5),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _buscarHorario,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2F7A72),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Text(
                                'Consultar horario',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: resultado == null
                          ? _SinResultado(
                              key: const ValueKey('empty'),
                              texto: _controller.text.trim().isEmpty
                                  ? 'Escribe un barrio para ver días y hora de recolección.'
                                  : 'No encontramos ese barrio. Prueba con La Consolata, Acacias o Yapura Sur.',
                            )
                          : _TarjetaHorario(
                              key: ValueKey(resultado!.barrio),
                              info: resultado!,
                            ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 230,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.white,
                            width: 1.8,
                          ),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Volver al menu',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TarjetaHorario extends StatelessWidget {
  final _HorarioInfo info;

  const _TarjetaHorario({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F2),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F1EB),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF2F7A72), width: 2),
            ),
            child: const Icon(Icons.access_time, color: Color(0xFF2F7A72)),
          ),
          const SizedBox(height: 14),
          Text(
            info.barrio,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF2F7A72),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            info.dias,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF245A54),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Hora aproximada: ${info.hora}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF245A54),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            info.detalle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF5B6F6C), fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _SinResultado extends StatelessWidget {
  final String texto;

  const _SinResultado({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(Icons.location_city, color: Color(0xFF2F7A72), size: 38),
          const SizedBox(height: 10),
          Text(
            texto,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF355A56),
              fontSize: 15,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 360,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(180),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0F0E8), Color(0x3382C5AE)],
          ),
        ),
      ),
    );
  }
}

class _LeafDecoration extends StatelessWidget {
  final bool flipped;

  const _LeafDecoration({this.flipped = false});

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..scale(flipped ? -1.0 : 1.0, 1.0),
      child: SizedBox(
        width: 70,
        height: 70,
        child: CustomPaint(painter: _LeafPainter()),
      ),
    );
  }
}

class _LeafPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF42A98D).withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path1 = Path()
      ..moveTo(size.width * 0.2, size.height * 0.85)
      ..quadraticBezierTo(
        size.width * 0.35,
        size.height * 0.55,
        size.width * 0.62,
        size.height * 0.52,
      )
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.36,
        size.width * 0.18,
        size.height * 0.14,
      );

    final path2 = Path()
      ..moveTo(size.width * 0.4, size.height * 0.86)
      ..quadraticBezierTo(
        size.width * 0.52,
        size.height * 0.54,
        size.width * 0.82,
        size.height * 0.34,
      )
      ..quadraticBezierTo(
        size.width * 0.7,
        size.height * 0.15,
        size.width * 0.46,
        size.height * 0.1,
      );

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HorarioInfo {
  final String barrio;
  final String dias;
  final String hora;
  final String detalle;

  const _HorarioInfo({
    required this.barrio,
    required this.dias,
    required this.hora,
    required this.detalle,
  });
}
