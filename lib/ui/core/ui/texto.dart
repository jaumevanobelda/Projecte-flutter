import 'package:flutter/material.dart';

enum TipoTexto { title, subtitle, body, secondary }

class Texto extends StatelessWidget {
  const new({super.key, required this.texto, this.tipo = TipoTexto.body});
  final String texto;
  final TipoTexto tipo;
  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: switch (tipo) {
        TipoTexto.title => const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0F172A),
        ),
        TipoTexto.subtitle => const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF0F172A),
        ),
        TipoTexto.body => const TextStyle(
          fontSize: 16,
          color: Color(0xFF0F172A),
        ),
        TipoTexto.secondary => const TextStyle(
          fontSize: 14,
          color: Color(0xFF0F172A),
        ),
      },
    );
  }
}
