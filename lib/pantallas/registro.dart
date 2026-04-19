import 'package:flutter/material.dart';

import '../marco/marco_app.dart';
import '../mock/demo_auth.dart';
import 'menu.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  bool aceptaTerminos = false;
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? mensajeError;

  @override
  void dispose() {
    nombreController.dispose();
    correoController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _limpiarError() {
    if (mensajeError != null) {
      setState(() {
        mensajeError = null;
      });
    }
  }

  void _registrar() {
    final nombre = nombreController.text.trim();
    final correo = correoController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (nombre.isEmpty ||
        correo.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        mensajeError = 'Completa todos los campos';
      });
      return;
    }

    if (!correo.contains('@') || !correo.contains('.')) {
      setState(() {
        mensajeError = 'Ingresa un correo válido';
      });
      return;
    }

    if (password.length < 5) {
      setState(() {
        mensajeError = 'La contraseña debe tener al menos 5 caracteres';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        mensajeError = 'Las contraseñas no coinciden';
      });
      return;
    }

    final error = DemoAuth.register(
      fullName: nombre,
      email: correo,
      password: password,
    );

    if (error != null) {
      setState(() {
        mensajeError = error;
      });
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MenuScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MarcoApp(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            color: Colors.grey[200],
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(22, 20, 22, 28),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E746C),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 24),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Vamos!',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Crea tu\nCuenta',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 34),
                _campoTexto(
                  controller: nombreController,
                  hint: 'Nombre Completo',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 14),
                _campoTexto(
                  controller: correoController,
                  hint: 'Correo - Email',
                  icon: Icons.mail_outline,
                ),
                const SizedBox(height: 14),
                _campoTexto(
                  controller: passwordController,
                  hint: 'Contraseña',
                  icon: Icons.lock_outline,
                  oculto: true,
                ),
                const SizedBox(height: 14),
                _campoTexto(
                  controller: confirmPasswordController,
                  hint: 'Nuevamente tu contraseña',
                  icon: Icons.lock_outline,
                  oculto: true,
                ),
                if (mensajeError != null) ...[
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEFEF),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFF2B3B3)),
                      ),
                      child: Text(
                        mensajeError!,
                        style: const TextStyle(
                          color: Color(0xFFA64646),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Row(
                    children: [
                      Checkbox(
                        value: aceptaTerminos,
                        activeColor: const Color(0xFF2E746C),
                        onChanged: (value) {
                          setState(() {
                            aceptaTerminos = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(width: 4),
                      const Expanded(
                        child: Text(
                          'Acepto los términos y la política de privacidad',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF2E746C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: aceptaTerminos ? _registrar : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E746C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Inscribirse',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Tienes una cuenta? ',
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Ingresar',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF2E746C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _campoTexto({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool oculto = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: TextField(
        controller: controller,
        obscureText: oculto,
        onChanged: (_) => _limpiarError(),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
          prefixIcon: Icon(icon, color: const Color(0xFF2E746C), size: 20),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: Color(0xFF2E746C), width: 1.6),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: Color(0xFF2E746C), width: 1.8),
          ),
        ),
      ),
    );
  }
}
