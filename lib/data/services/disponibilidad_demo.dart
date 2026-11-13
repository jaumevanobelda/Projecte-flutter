import 'package:entrega_1/domain/models/disponibilidad_dia.dart';
import 'package:entrega_1/domain/models/franja_disponibilidad.dart';

class DisponibilidadDemo {
  static List<DisponibilidadDia> generar({
    required String espacioId,
    required DateTime referencia,
  }) {
    final hoy = DateTime(referencia.year, referencia.month, referencia.day);
    return List<DisponibilidadDia>.generate(7, (desplazamiento) {
      final fecha = DateTime(hoy.year, hoy.month, hoy.day + desplazamiento);
      return DisponibilidadDia(
        espacioId: espacioId,
        fecha: fecha,
        franjas: <FranjaDisponibilidad>[
          FranjaDisponibilidad(
            inicio: DateTime(fecha.year, fecha.month, fecha.day, 10),
            fin: DateTime(fecha.year, fecha.month, fecha.day, 12),
            disponible: true,
          ),
          FranjaDisponibilidad(
            inicio: DateTime(fecha.year, fecha.month, fecha.day, 13),
            fin: DateTime(fecha.year, fecha.month, fecha.day, 15),
            disponible: false,
          ),
          FranjaDisponibilidad(
            inicio: DateTime(fecha.year, fecha.month, fecha.day, 17),
            fin: DateTime(fecha.year, fecha.month, fecha.day, 19),
            disponible: true,
          ),
        ],
      );
    });
  }
}
