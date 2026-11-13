import 'package:entrega_1/data/repositories/espacios_repository.dart';
import 'package:entrega_1/data/repositories/reservas_repository.dart';
import 'package:entrega_1/data/repositories/usuarios_repository.dart';
import 'package:entrega_1/data/services/datos_demo.dart';
import 'package:entrega_1/data/services/datos_simulados_service.dart';
import 'package:entrega_1/domain/models/reserva.dart';
import 'package:entrega_1/ui/core/ui/reserva_tarjeta.dart';
import 'package:entrega_1/ui/core/ui/texto.dart';
import 'package:flutter/material.dart';

class MisReservasScreen extends StatelessWidget {
  const MisReservasScreen({super.key, this.reservas});

  final List<Reserva>? reservas;

  List<Reserva> _reservasDemo() {
    final service = DatosSimuladosService(
      espacios: espaciosDemo,
      reservas: reservasDemo,
      usuarios: usuariosDemo,
      comentarios: comentariosDemo,
      disponibilidad: disponibilidadDemo,
    );
    final espacios = EspaciosRepository(service: service);
    final usuarios = UsuariosRepository(service: service);
    return ReservasRepository(
      service: service,
      espacios: espacios,
      usuarios: usuarios,
    ).obtenerPorUsuario('u1');
  }

  @override
  Widget build(BuildContext context) {
    final reservasDisponibles = reservas ?? _reservasDemo();
    return Scaffold(
      appBar: AppBar(
        title: const Texto(texto: 'Mis reservas', tipo: TipoTexto.subtitle),
      ),
      body: reservasDisponibles.isEmpty
          ? const _SinReservas()
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              children: [
                const Texto(texto: 'Tus solicitudes', tipo: TipoTexto.title),
                const SizedBox(height: 8),
                const Texto(
                  texto:
                      'Consulta horarios, estados, extras y datos de contacto.',
                ),
                const SizedBox(height: 20),
                ...reservasDisponibles.map(
                  (reserva) => ReservaTarjeta(reserva: reserva),
                ),
              ],
            ),
    );
  }
}

class _SinReservas extends StatelessWidget {
  const _SinReservas();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.event_busy_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            const Texto(
              texto: 'Todavía no tienes reservas',
              tipo: TipoTexto.subtitle,
            ),
            const SizedBox(height: 8),
            const Texto(
              texto: 'Las solicitudes que hagas aparecerán aquí.',
              tipo: TipoTexto.secondary,
            ),
          ],
        ),
      ),
    );
  }
}