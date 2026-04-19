import 'package:flutter/material.dart';

import '../marco/marco_app.dart';

class ReporteScreen extends StatefulWidget {
  const ReporteScreen({super.key});

  @override
  State<ReporteScreen> createState() => _ReporteScreenState();
}

class _ReporteScreenState extends State<ReporteScreen> {
  static const List<String> _barrios = [
    'Barrio la Esperanza',
    'La Consolata',
    'Ciudadela Siglo XXI',
    'Acacias',
    'Yapura Sur',
  ];

  final TextEditingController _descripcionController = TextEditingController(
    text: 'Basura acumulada en la esquina',
  );

  String barrioSeleccionado = _barrios.first;
  String tipoProblema = 'Basura acumulada';
  bool fotoAdjunta = true;
  String? mensajeSuperior;

  @override
  void dispose() {
    _descripcionController.dispose();
    super.dispose();
  }

  void _mostrarMensaje(String mensaje) {
    setState(() {
      mensajeSuperior = mensaje;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted || mensajeSuperior != mensaje) {
        return;
      }
      setState(() {
        mensajeSuperior = null;
      });
    });
  }

  void _enviarReporte() {
    _mostrarMensaje('Reporte enviado');
    setState(() {
      barrioSeleccionado = _barrios.first;
      tipoProblema = 'Basura acumulada';
      fotoAdjunta = false;
      _descripcionController.text = 'Basura acumulada en la esquina';
    });
  }

  void _cambiarFoto() {
    setState(() {
      fotoAdjunta = !fotoAdjunta;
    });

    _mostrarMensaje(
      fotoAdjunta ? 'Foto adjunta al reporte' : 'Foto removida del reporte',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MarcoApp(
      child: Scaffold(
        backgroundColor: const Color(0xFFD2E1DD),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2F7A72),
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
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Reportar\nBasura',
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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(26, 28, 26, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Barrio',
                            style: TextStyle(
                              color: Color(0xFF4D6662),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            initialValue: barrioSeleccionado,
                            items: _barrios
                                .map(
                                  (barrio) => DropdownMenuItem<String>(
                                    value: barrio,
                                    child: Text(barrio),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                barrioSeleccionado = value;
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: const TextStyle(
                              color: Color(0xFF475854),
                              fontSize: 14,
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF355A56),
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Descripción del problema',
                            style: TextStyle(
                              color: Color(0xFF4D6662),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _campoTexto(_descripcionController, maxLines: 2),
                          const SizedBox(height: 18),
                          const Text(
                            'Tipo de problema',
                            style: TextStyle(
                              color: Color(0xFF4D6662),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _tipoChip('Basura acumulada'),
                              _tipoChip('Mal olor'),
                              _tipoChip('Bolsa rota'),
                              _tipoChip('Escombros'),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              const Text(
                                'Foto del lugar:',
                                style: TextStyle(
                                  color: Color(0xFF4D6662),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.photo_camera,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                              const Spacer(),
                              TextButton.icon(
                                onPressed: _cambiarFoto,
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF2F7A72),
                                ),
                                icon: Icon(
                                  fotoAdjunta ? Icons.edit : Icons.add_a_photo,
                                  size: 18,
                                ),
                                label: Text(
                                  fotoAdjunta
                                      ? 'Cambiar foto'
                                      : 'Adjuntar foto',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: SizedBox(
                                height: 180,
                                child: fotoAdjunta
                                    ? Image.asset(
                                        'assets/images/basura_report.jpg',
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        color: const Color(0xFFF3F6F5),
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons
                                                  .add_photo_alternate_outlined,
                                              size: 44,
                                              color: Color(0xFF6D8882),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Adjunta una foto del lugar',
                                              style: TextStyle(
                                                color: Color(0xFF4D6662),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F2EF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 18,
                                  color: Color(0xFF2F7A72),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Tu reporte ayudará a priorizar la ruta de recolección y mejorar la atención del sector.',
                                    style: TextStyle(
                                      color: Color(0xFF355A56),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              onPressed: _enviarReporte,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2F7A72),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              child: const Text(
                                'Enviar reporte',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: SizedBox(
                              width: 200,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD1E2DE),
                                  foregroundColor: const Color(0xFF355A56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Volver al menú',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
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
              if (mensajeSuperior != null)
                Positioned(
                  top: 10,
                  left: 18,
                  right: 18,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF245A54),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      mensajeSuperior!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campoTexto(TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Color(0xFF475854), fontSize: 14),
    );
  }

  Widget _tipoChip(String label) {
    final selected = tipoProblema == label;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() {
          tipoProblema = label;
          if (_descripcionController.text.trim().isEmpty ||
              _descripcionController.text == 'Basura acumulada en la esquina' ||
              _descripcionController.text ==
                  'Mal olor en el punto de recoleccion' ||
              _descripcionController.text ==
                  'Bolsa rota con residuos en la vía' ||
              _descripcionController.text == 'Escombros ocupando el anden') {
            _descripcionController.text = _descripcionSugerida(label);
          }
        });
      },
      selectedColor: const Color(0xFF2F7A72),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : const Color(0xFF355A56),
        fontWeight: FontWeight.w600,
      ),
      side: const BorderSide(color: Color(0xFFB7CBC6)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    );
  }

  String _descripcionSugerida(String tipo) {
    switch (tipo) {
      case 'Mal olor':
        return 'Mal olor en el punto de recoleccion';
      case 'Bolsa rota':
        return 'Bolsa rota con residuos en la vía';
      case 'Escombros':
        return 'Escombros ocupando el anden';
      default:
        return 'Basura acumulada en la esquina';
    }
  }
}
