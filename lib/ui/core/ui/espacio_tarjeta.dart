import 'package:entrega_1/data/models/espacio_dto.dart';
import 'package:entrega_1/ui/core/ui/texto.dart';
import 'package:flutter/material.dart';

class EspacioTarjeta extends StatelessWidget {
  const EspacioTarjeta({super.key, required this.espacio, this.onTap});

  final EspacioDto espacio;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actividades = espacio.actividades.take(2).join(' · ');
    final precio = (espacio.precioHoraCentimos / 100).toStringAsFixed(2);

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              width: double.infinity,
              child: Image.asset(
                espacio.imagenAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return ColoredBox(
                    color: theme.colorScheme.primaryContainer,
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 48,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Texto(
                    texto: espacio.nombre,
                    tipo: TipoTexto.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    estilo: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _DatoEspacio(
                    icono: Icons.location_on_outlined,
                    texto: espacio.ubicacion,
                  ),
                  const SizedBox(height: 6),
                  _DatoEspacio(
                    icono: Icons.groups_outlined,
                    texto: 'Hasta ${espacio.aforo} personas',
                  ),
                  if (actividades.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    _DatoEspacio(
                      icono: Icons.local_activity_outlined,
                      texto: actividades,
                    ),
                  ],
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Texto(
                        texto: '$precio ${espacio.moneda} / hora',
                        estilo: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (onTap != null)
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: theme.colorScheme.primary,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DatoEspacio extends StatelessWidget {
  const _DatoEspacio({required this.icono, required this.texto});

  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icono, size: 18, color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 8),
        Expanded(
          child: Texto(
            texto: texto,
            tipo: TipoTexto.secondary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
