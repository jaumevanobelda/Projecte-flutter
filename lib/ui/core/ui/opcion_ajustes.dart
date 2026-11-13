import 'package:entrega_1/ui/core/ui/texto.dart';
import 'package:flutter/material.dart';

class OpcionAjustes extends StatelessWidget {
  const OpcionAjustes({
    super.key,
    required this.icono,
    required this.titulo,
    required this.descripcion,
    this.onTap,
    this.trailing,
  });

  final IconData icono;
  final String titulo;
  final String descripcion;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          icono,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      title: Texto(texto: titulo, tipo: TipoTexto.body),
      subtitle: Texto(texto: descripcion, tipo: TipoTexto.secondary),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
