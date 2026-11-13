import 'package:entrega_1/domain/models/reserva.dart';
import 'package:entrega_1/ui/core/ui/texto.dart';
import 'package:flutter/material.dart';

class ReservaTarjeta extends StatelessWidget {
  const ReservaTarjeta({super.key, required this.reserva, this.onTap});

  final Reserva reserva;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final precio = (reserva.precioTotalCentimos / 100).toStringAsFixed(2);
    final servicios = reserva.serviciosContratados.isEmpty
        ? 'Sin extras'
        : reserva.serviciosContratados.map((servicio) => servicio.nombre).join(' · ');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Texto(
                      texto: reserva.espacio.nombre,
                      tipo: TipoTexto.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _EstadoReserva(estado: reserva.estado),
                ],
              ),
              const SizedBox(height: 12),
              _DatoReserva(
                icono: Icons.event_outlined,
                texto: '${_fecha(reserva.inicio)} · ${_hora(reserva.inicio)}–${_hora(reserva.fin)}',
              ),
              _DatoReserva(
                icono: Icons.local_activity_outlined,
                texto: reserva.actividad,
              ),
              _DatoReserva(
                icono: Icons.groups_outlined,
                texto: '${reserva.asistentes} asistentes',
              ),
              _DatoReserva(
                icono: Icons.add_circle_outline,
                texto: servicios,
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Texto(
                    texto: 'Contacto: ${reserva.espacio.contacto.nombre}',
                    tipo: TipoTexto.secondary,
                  ),
                  Texto(
                    texto: '$precio ${reserva.moneda}',
                    tipo: TipoTexto.subtitle,
                    estilo: TextStyle(color: theme.colorScheme.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _fecha(DateTime fecha) {
    return '${fecha.day.toString().padLeft(2, '0')}/'
        '${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
  }

  static String _hora(DateTime fecha) {
    return '${fecha.hour.toString().padLeft(2, '0')}:'
        '${fecha.minute.toString().padLeft(2, '0')}';
  }
}

class _DatoReserva extends StatelessWidget {
  const _DatoReserva({required this.icono, required this.texto});

  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Icon(icono, size: 18, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 8),
          Expanded(child: Texto(texto: texto, tipo: TipoTexto.secondary)),
        ],
      ),
    );
  }
}

class _EstadoReserva extends StatelessWidget {
  const _EstadoReserva({required this.estado});

  final EstadoReserva estado;

  @override
  Widget build(BuildContext context) {
    final (texto, color) = switch (estado) {
      EstadoReserva.confirmada => ('Confirmada', Colors.green),
      EstadoReserva.pendiente => ('Pendiente', Colors.orange.shade800),
      EstadoReserva.cancelada => ('Cancelada', Colors.red),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Texto(
        texto: texto,
        tipo: TipoTexto.secondary,
        estilo: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}