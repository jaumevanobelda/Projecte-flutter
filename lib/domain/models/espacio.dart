import 'package:entrega_1/domain/models/contacto_local.dart';

import 'comentario.dart';
import 'servicio_extra.dart';

class Espacio {
  const Espacio({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.ubicacion,
    required this.horario,
    required this.condicionesUso,
    required this.aforo,
    required this.imagenAsset,
    required this.imagenesAssets,
    this.sitioWeb,
    required this.serviciosDisponibles,
    required this.actividades,
    required this.equipamiento,
    required this.precioHoraCentimos,
    required this.moneda,
    required this.contacto,
  });

  final String id;
  final String nombre;
  final String descripcion;
  final String ubicacion;
  final String horario;
  final String condicionesUso;
  final int aforo;
  final String imagenAsset;
  final List<String> imagenesAssets;
  final String? sitioWeb;
  final List<ServicioExtra> serviciosDisponibles;
  final List<String> actividades;
  final List<String> equipamiento;
  final int precioHoraCentimos;
  final String moneda;
  final ContactoLocal contacto;

  bool admiteActividad(String actividad) {
    return actividades.contains(actividad);
  }

  double? mediaValoraciones(List<Comentario> comentarios) {
    final delEspacio = comentarios
        .where((comentario) => comentario.espacioId == id)
        .toList();
    if (delEspacio.isEmpty) {
      return null;
    }

    final suma = delEspacio.fold<int>(
      0,
      (total, comentario) => total + comentario.puntuacion,
    );
    return suma / delEspacio.length;
  }
}
