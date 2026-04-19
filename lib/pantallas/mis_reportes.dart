import 'package:flutter/material.dart';

import '../marco/marco_app.dart';

class MisReportesScreen extends StatelessWidget {
  const MisReportesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const reportes = [
      _ReporteItem(
        titulo: 'Basura acumulada en esquina',
        ubicacion: 'La Consolata, carrera 8',
        estado: 'Pendiente',
      ),
      _ReporteItem(
        titulo: 'Bolsas rotas en el anden',
        ubicacion: 'Acacias, calle 17',
        estado: 'En proceso',
      ),
      _ReporteItem(
        titulo: 'Escombros frente al parque',
        ubicacion: 'Ciudadela Siglo XXI',
        estado: 'Solucionado',
      ),
    ];

    return MarcoApp(
      child: Scaffold(
        backgroundColor: const Color(0xFFD5E3DE),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 26),
                decoration: const BoxDecoration(
                  color: Color(0xFF2E746C),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(34),
                    bottomRight: Radius.circular(34),
                  ),
                ),
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
                    const SizedBox(height: 6),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mis\nreportes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 31,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: reportes.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final reporte = reportes[index];
                            return Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.97),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 12,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.assignment_outlined,
                                        color: Color(0xFF2E746C),
                                        size: 28,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          reporte.titulo,
                                          style: const TextStyle(
                                            color: Color(0xFF2E746C),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      _estadoChip(reporte.estado),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Color(0xFF68817C),
                                        size: 18,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          reporte.ubicacion,
                                          style: const TextStyle(
                                            color: Color(0xFF57706C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF2E746C),
                              width: 1.6,
                            ),
                            foregroundColor: const Color(0xFF2E746C),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _estadoChip(String estado) {
    Color fondo;
    Color texto;

    switch (estado) {
      case 'En proceso':
        fondo = const Color(0xFFFFE9B5);
        texto = const Color(0xFF8D5C00);
        break;
      case 'Solucionado':
        fondo = const Color(0xFFD9F2DD);
        texto = const Color(0xFF1E6D34);
        break;
      default:
        fondo = const Color(0xFFF8D5D5);
        texto = const Color(0xFFA33A3A);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        estado,
        style: TextStyle(
          color: texto,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ReporteItem {
  final String titulo;
  final String ubicacion;
  final String estado;

  const _ReporteItem({
    required this.titulo,
    required this.ubicacion,
    required this.estado,
  });
}
