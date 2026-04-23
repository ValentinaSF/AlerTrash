import 'package:flutter/material.dart';

import '../marco/marco_app.dart';
import 'alerta_demo.dart';

class ConfiguracionAlertasScreen extends StatefulWidget {
  const ConfiguracionAlertasScreen({super.key});

  @override
  State<ConfiguracionAlertasScreen> createState() =>
      _ConfiguracionAlertasScreenState();
}

class _ConfiguracionAlertasScreenState
    extends State<ConfiguracionAlertasScreen> {
  bool alertasActivas = true;
  int minutosAntes = 10;
  String? mensajeGuardado;

  void _mostrarMensaje(String mensaje) {
    setState(() {
      mensajeGuardado = mensaje;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted || mensajeGuardado != mensaje) {
        return;
      }
      setState(() {
        mensajeGuardado = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MarcoApp(
      child: Scaffold(
        backgroundColor: const Color(0xFFD6E3DF),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
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
                            'Configuracion\nde Alertas',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
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
                      padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.96),
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
                                const Text(
                                  'Elige cómo quieres recibir el aviso cuando el camión recolector esté por pasar cerca de tu sector.',
                                  style: TextStyle(
                                    color: Color(0xFF45615D),
                                    fontSize: 14,
                                    height: 1.35,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F2EF),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Activar Alertas',
                                          style: TextStyle(
                                            color: Color(0xFF2E746C),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Switch(
                                        value: alertasActivas,
                                        activeThumbColor: const Color(
                                          0xFF2E746C,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            alertasActivas = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.96),
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
                                const Text(
                                  'Tiempo de anticipación',
                                  style: TextStyle(
                                    color: Color(0xFF2E746C),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _opcionTiempo(5),
                                _opcionTiempo(10),
                                _opcionTiempo(15),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AlertaDemoScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Simular alerta',
                                style: TextStyle(
                                  color: Color(0xFF2E746C),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFF2E746C),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              onPressed: () {
                                final estado = alertasActivas
                                    ? 'Alertas guardadas: $minutosAntes minutos antes'
                                    : 'Alertas desactivadas';
                                _mostrarMensaje(estado);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E746C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Guardar configuración',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
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
                  ),
                ],
              ),
              if (mensajeGuardado != null)
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
                      mensajeGuardado!,
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

  Widget _opcionTiempo(int minutos) {
    final activo = minutosAntes == minutos;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: activo ? const Color(0xFFE8F2EF) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: RadioListTile<int>(
        value: minutos,
        groupValue: minutosAntes,
        activeColor: const Color(0xFF2E746C),
        contentPadding: const EdgeInsets.symmetric(horizontal: 6),
        title: Text(
          '$minutos minutos antes',
          style: const TextStyle(
            color: Color(0xFF355A56),
            fontWeight: FontWeight.w600,
          ),
        ),
        onChanged: alertasActivas
            ? (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  minutosAntes = value;
                });
              }
            : null,
      ),
    );
  }
}
