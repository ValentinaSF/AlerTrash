import 'package:flutter/material.dart';

import '../marco/marco_app.dart';

class HorariosScreen extends StatefulWidget {
  const HorariosScreen({super.key});

  @override
  State<HorariosScreen> createState() => _HorariosScreenState();
}

class _HorariosScreenState extends State<HorariosScreen> {
  static const List<_HorarioSector> sectores = [
    _HorarioSector(
      nombre: 'Ciudadela Siglo XXI',
      dia: 'Lunes, Miercoles y Viernes',
      horario: '7:00 PM - 9:00 PM',
      detalle: 'Comparte ruta con Juan XXIII y La Consolata.',
    ),
    _HorarioSector(
      nombre: 'Juan XXIII',
      dia: 'Lunes, Miercoles y Viernes',
      horario: '7:00 PM - 9:00 PM',
      detalle: 'Comparte ruta con Ciudadela Siglo XXI y La Consolata.',
    ),
    _HorarioSector(
      nombre: 'La Consolata',
      dia: 'Lunes, Miercoles y Viernes',
      horario: '7:00 PM - 9:00 PM',
      detalle: 'Ruta nocturna del mismo grupo de barrios.',
    ),
    _HorarioSector(
      nombre: 'El Portal del Mirador',
      dia: 'Martes, Jueves y Sabado',
      horario: '8:00 AM - 10:00 AM',
      detalle: 'Comparte recolección con Acolsure, La Paz y Los Pinos.',
    ),
    _HorarioSector(
      nombre: 'Acolsure',
      dia: 'Martes, Jueves y Sabado',
      horario: '8:00 AM - 10:00 AM',
      detalle: 'Comparte recolección con El Portal del Mirador y La Paz.',
    ),
    _HorarioSector(
      nombre: 'La Paz',
      dia: 'Martes, Jueves y Sabado',
      horario: '8:00 AM - 10:00 AM',
      detalle: 'Comparte recolección con Los Pinos y Yapura Sur.',
    ),
    _HorarioSector(
      nombre: 'Los Pinos',
      dia: 'Martes, Jueves y Sabado',
      horario: '8:00 AM - 10:00 AM',
      detalle: 'Barrio atendido en la ruta matutina.',
    ),
    _HorarioSector(
      nombre: 'Yapura Sur',
      dia: 'Martes, Jueves y Sabado',
      horario: '8:00 AM - 10:00 AM',
      detalle: 'Barrio incluido en la jornada de la manaña.',
    ),
  ];

  _HorarioSector? sectorSeleccionado = sectores.first;

  @override
  Widget build(BuildContext context) {
    final sector = sectorSeleccionado;

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
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
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
                            'Selecciona tu barrio',
                            style: TextStyle(
                              color: Color(0xFF2F7A72),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<_HorarioSector>(
                            value: sectorSeleccionado,
                            isExpanded: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFF3F6F5),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF2F7A72),
                            ),
                            items: sectores
                                .map(
                                  (item) => DropdownMenuItem<_HorarioSector>(
                                    value: item,
                                    child: Text(item.nombre),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                sectorSeleccionado = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: sector == null
                            ? const SizedBox.shrink()
                            : _TarjetaHorario(
                                key: ValueKey(sector.nombre),
                                info: sector,
                              ),
                      ),
                    ),
                    const SizedBox(height: 18),
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
                          'Volver al menú',
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
  final _HorarioSector info;

  const _TarjetaHorario({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisSize: MainAxisSize.min,
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
            info.nombre,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF2F7A72),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            info.dia,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF245A54),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Horario: ${info.horario}',
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

class _HorarioSector {
  final String nombre;
  final String dia;
  final String horario;
  final String detalle;

  const _HorarioSector({
    required this.nombre,
    required this.dia,
    required this.horario,
    required this.detalle,
  });
}
