import 'franja_disponibilidad.dart';

class DisponibilidadDia {
  DisponibilidadDia({
    required this.espacioId,
    required this.fecha,
    required this.franjas,
  }) : assert(fecha.hour == 0),
       assert(fecha.minute == 0),
       assert(fecha.second == 0),
       assert(fecha.millisecond == 0),
       assert(fecha.microsecond == 0),
       assert(_franjasValidas(fecha, franjas));

  final String espacioId;
  final DateTime fecha;
  final List<FranjaDisponibilidad> franjas;

  static bool _franjasValidas(
    DateTime fecha,
    List<FranjaDisponibilidad> franjas,
  ) {
    for (var i = 0; i < franjas.length; i++) {
      final franja = franjas[i];
      if (!_esDelMismoDia(franja.inicio, fecha) ||
          !_esDelMismoDia(franja.fin, fecha) ||
          !franja.fin.isAfter(franja.inicio)) {
        return false;
      }
      for (var j = i + 1; j < franjas.length; j++) {
        final otra = franjas[j];
        if (franja.inicio.isBefore(otra.fin) &&
            otra.inicio.isBefore(franja.fin)) {
          return false;
        }
      }
    }
    return true;
  }

  static bool _esDelMismoDia(DateTime fecha, DateTime referencia) {
    return fecha.year == referencia.year &&
        fecha.month == referencia.month &&
        fecha.day == referencia.day;
  }
}
