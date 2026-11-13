import 'package:entrega_1/ui/core/ui/texto.dart';
import 'package:flutter/material.dart';

enum TipoBoton { principal, secundario }

class Boton extends StatelessWidget {
  const new({
    super.key,
    required this.texto,
    this.tipo = TipoBoton.principal,
    this.onPressed,
  });
  final String texto;
  final TipoBoton tipo;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed ?? () => (),
      style: switch (tipo) {
        TipoBoton.principal => FilledButton.styleFrom(
          backgroundColor: Color(0xFF0563EB),
          foregroundColor: Color(0xFFF8FAFC),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        ),
        TipoBoton.secundario => FilledButton.styleFrom(
          backgroundColor: Color(0xFF0EA5E9),
          foregroundColor: Color(0xFF0F172A),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        // TipoBoton.volver => FilledButton.styleFrom(backgroundColor: Color(value)),
      },
      child: Text(texto),
    );
  }
}
