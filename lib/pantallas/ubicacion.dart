import 'package:flutter/material.dart';

import '../marco/marco_app.dart';

class UbicacionScreen extends StatefulWidget {
  const UbicacionScreen({super.key});

  @override
  State<UbicacionScreen> createState() => _UbicacionScreenState();
}

class _UbicacionScreenState extends State<UbicacionScreen> {
  bool camionCerca = false;

  @override
  Widget build(BuildContext context) {
    return MarcoApp(
      child: Scaffold(
        backgroundColor: const Color(0xFFC9D9D6),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
                child: Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Color(0xFF355A56),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Ubicación en tiempo\nreal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF23433F),
                    height: 1.05,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(painter: _MapaPainter()),
                        ),
                        const Positioned(
                          left: 34,
                          top: 148,
                          child: _UbicacionActualMarker(),
                        ),
                        const Positioned(
                          left: 40,
                          top: 176,
                          child: _MapLabel('Mi ubicacion'),
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOutCubic,
                          right: camionCerca ? 134 : 42,
                          top: camionCerca ? 118 : 198,
                          child: const _CamionMarker(),
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOutCubic,
                          right: camionCerca ? 106 : 18,
                          top: camionCerca ? 88 : 170,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.94),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              camionCerca ? 'Camión cerca' : 'Camión en ruta',
                              style: const TextStyle(
                                color: Color(0xFF2E746C),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(18, 0, 18, 20),
                padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
                decoration: const BoxDecoration(
                  color: Color(0xFF2E746C),
                  borderRadius: BorderRadius.all(Radius.circular(34)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 290,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            camionCerca = !camionCerca;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD8E5E0),
                          foregroundColor: const Color(0xFF2E746C),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: const Text(
                          'Actualizar Ubicación',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.white,
                            width: 1.8,
                          ),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: const Text(
                          'Volver al menu principal',
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

class _UbicacionActualMarker extends StatelessWidget {
  const _UbicacionActualMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: const Color(0xFFFF61C7),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: const Icon(Icons.person, color: Colors.white, size: 12),
    );
  }
}

class _CamionMarker extends StatelessWidget {
  const _CamionMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(
        Icons.local_shipping,
        color: Color(0xFF4C8F2F),
        size: 28,
      ),
    );
  }
}

class _MapLabel extends StatelessWidget {
  final String text;

  const _MapLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF425856),
        ),
      ),
    );
  }
}

class _MapaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = const Color(0xFFF1F0EC);
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    final roadPaint = Paint()
      ..color = const Color(0xFFD7D9DD)
      ..strokeCap = StrokeCap.round;
    final thinRoadPaint = Paint()
      ..color = const Color(0xFFE7E8EB)
      ..strokeCap = StrokeCap.round;
    final accentRoadPaint = Paint()
      ..color = const Color(0xFFC7CDD4)
      ..strokeCap = StrokeCap.round;

    void road(Offset start, Offset end, double width, Paint paint) {
      paint.strokeWidth = width;
      canvas.drawLine(start, end, paint);
    }

    road(const Offset(18, 40), Offset(size.width - 28, 46), 22, roadPaint);
    road(
      const Offset(34, 102),
      Offset(size.width - 20, 116),
      19,
      thinRoadPaint,
    );
    road(const Offset(12, 176), Offset(size.width - 26, 158), 22, roadPaint);
    road(
      const Offset(34, 250),
      Offset(size.width - 18, 234),
      18,
      thinRoadPaint,
    );
    road(const Offset(20, 322), Offset(size.width - 34, 306), 20, roadPaint);
    road(const Offset(46, 16), const Offset(92, 350), 18, accentRoadPaint);
    road(const Offset(124, 28), const Offset(154, 354), 20, roadPaint);
    road(const Offset(220, 22), const Offset(248, 336), 18, thinRoadPaint);
    road(
      const Offset(258, 18),
      Offset(size.width - 48, 332),
      18,
      accentRoadPaint,
    );

    final blockPaint = Paint()..color = const Color(0xFFE9E7E0);
    final blocks = <Rect>[
      const Rect.fromLTWH(34, 72, 62, 40),
      const Rect.fromLTWH(108, 82, 54, 34),
      const Rect.fromLTWH(184, 76, 54, 40),
      const Rect.fromLTWH(246, 82, 54, 36),
      const Rect.fromLTWH(64, 144, 42, 34),
      const Rect.fromLTWH(184, 142, 64, 30),
      const Rect.fromLTWH(88, 218, 52, 42),
      const Rect.fromLTWH(236, 206, 48, 40),
      const Rect.fromLTWH(36, 290, 58, 38),
      const Rect.fromLTWH(138, 284, 58, 38),
      const Rect.fromLTWH(226, 276, 52, 42),
    ];

    for (final block in blocks) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(block, const Radius.circular(10)),
        blockPaint,
      );
    }

    final labelStyle = TextStyle(
      color: const Color(0xFF757A82).withOpacity(0.85),
      fontSize: 11,
      fontWeight: FontWeight.w500,
    );

    _drawLabel(canvas, 'Carrera 8', const Offset(112, 140), -1.2, labelStyle);
    _drawLabel(canvas, 'Calle 18', const Offset(180, 116), -0.18, labelStyle);
    _drawLabel(canvas, 'Calle 17', const Offset(168, 182), -0.18, labelStyle);
    _drawLabel(canvas, 'Calle 16', const Offset(176, 266), -0.12, labelStyle);
    _drawLabel(canvas, 'Carrera 7', const Offset(230, 134), -1.18, labelStyle);
    _drawLabel(canvas, 'Carrera 9', const Offset(292, 274), -1.25, labelStyle);
  }

  void _drawLabel(
    Canvas canvas,
    String text,
    Offset position,
    double rotation,
    TextStyle style,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    canvas.save();
    canvas.translate(position.dx, position.dy);
    canvas.rotate(rotation);
    textPainter.paint(canvas, Offset.zero);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
