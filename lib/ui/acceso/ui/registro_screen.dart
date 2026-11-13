import 'package:entrega_1/ui/core/ui/boton.dart';
import 'package:entrega_1/ui/core/ui/texto.dart';
import 'package:flutter/material.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key, this.onRegistrado, this.onVolver});

  final VoidCallback? onRegistrado;
  final VoidCallback? onVolver;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Form(
          child: Column(
            children: [
            Texto(texto: "Registro", tipo: TipoTexto.title),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nombre completo',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Correo electrónico',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Contraseña',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Confirmar contraseña',
              ),
            ),
            Boton(
              texto: 'Crear cuenta demo',
              tipo: TipoBoton.principal,
              onPressed: onRegistrado,
            ),
            const SizedBox(height: 12),
            Boton(
              texto: 'Volver al acceso',
              tipo: TipoBoton.secundario,
              onPressed: onVolver,
            ),
            ],
          ),
        ),
      ),
    );
  }
}
