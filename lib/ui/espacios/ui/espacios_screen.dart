import 'package:entrega_1/data/models/espacio_dto.dart';
import 'package:entrega_1/data/repositories/comentarios_repository.dart';
import 'package:entrega_1/data/repositories/disponibilidad_repository.dart';
import 'package:entrega_1/data/repositories/espacios_repository.dart';
import 'package:entrega_1/data/repositories/usuarios_repository.dart';
import 'package:entrega_1/data/services/datos_demo.dart';
import 'package:entrega_1/data/services/datos_simulados_service.dart';
import 'package:entrega_1/ui/espacios/ui/espacio_detalle_screen.dart';
import 'package:entrega_1/ui/core/ui/espacio_tarjeta.dart';
import 'package:entrega_1/ui/core/ui/texto.dart';
import 'package:entrega_1/ui/reservas/ui/nueva_reserva_screen.dart';
import 'package:flutter/material.dart';

class EspaciosScreen extends StatelessWidget {
  const EspaciosScreen({super.key, this.espacios, this.onEspacioSeleccionado});

  final List<EspacioDto>? espacios;
  final ValueChanged<EspacioDto>? onEspacioSeleccionado;

  void _seleccionarEspacio(BuildContext context, EspacioDto espacio) {
    if (onEspacioSeleccionado != null) {
      onEspacioSeleccionado!(espacio);
      return;
    }

    final service = DatosSimuladosService(
      espacios: espaciosDemo,
      reservas: reservasDemo,
      usuarios: usuariosDemo,
      comentarios: comentariosDemo,
      disponibilidad: disponibilidadDemo,
    );
    final espaciosRepository = EspaciosRepository(service: service);
    final espacioSeleccionado = espaciosRepository.obtenerPorId(espacio.id);

    if (espacioSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Texto(texto: 'No se pudo cargar el espacio.')),
      );
      return;
    }

    final usuariosRepository = UsuariosRepository(service: service);
    final comentariosRepository = ComentariosRepository(
      service: service,
      usuarios: usuariosRepository,
      espacios: espaciosRepository,
    );
    final disponibilidadRepository = DisponibilidadRepository(
      service: service,
      espacios: espaciosRepository,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EspacioDetalleScreen(
          espacio: espacioSeleccionado,
          comentarios: comentariosRepository.obtenerPorEspacio(espacio.id),
          disponibilidad: disponibilidadRepository.obtenerSieteDias(
            espacio.id,
            fechaReferenciaDemo,
          ),
          onReservar: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NuevaReservaScreen(
                  espacio: espacioSeleccionado,
                  onConfirmada: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Texto(
                          texto: 'Solicitud demo preparada. No se ha guardado ninguna reserva.',
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final espaciosDisponibles = espacios ?? espaciosDemo;

    return Scaffold(
      appBar: AppBar(
        title: const Texto(
          texto: 'Espacios disponibles',
          tipo: TipoTexto.subtitle,
        ),
        centerTitle: false,
      ),
      body: espaciosDisponibles.isEmpty
          ? const _EstadoVacio()
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              children: [
                Texto(
                  texto: 'Encuentra el espacio ideal',
                  tipo: TipoTexto.title,
                  estilo: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Texto(
                  texto: 'Explora espacios para reuniones, talleres y celebraciones.',
                ),
                const SizedBox(height: 20),
                ...espaciosDisponibles.map(
                  (espacio) => EspacioTarjeta(
                    espacio: espacio,
                    onTap: () => _seleccionarEspacio(context, espacio),
                  ),
                ),
              ],
            ),
    );
  }
}

class _EstadoVacio extends StatelessWidget {
  const _EstadoVacio();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.meeting_room_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            const Texto(
              texto: 'No hay espacios disponibles',
              tipo: TipoTexto.subtitle,
            ),
            const SizedBox(height: 8),
            const Texto(
              texto: 'Vuelve a intentarlo más tarde.',
              tipo: TipoTexto.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
