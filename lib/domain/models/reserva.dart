import 'espacio.dart';
import 'servicio_contratado.dart';
import 'usuario.dart';

enum EstadoReserva { confirmada, pendiente, cancelada }

class Reserva {
  Reserva({
    required this.id,
    required this.espacio,
    required this.usuario,
    required this.actividad,
    required this.inicio,
    required this.fin,
    required this.asistentes,
    required this.estado,
    required this.serviciosContratados,
    required this.tarifaHoraCentimos,
    required this.precioTotalCentimos,
    required this.moneda,
  }) : assert(asistentes > 0),
       assert(asistentes <= espacio.aforo),
       assert(fin.isAfter(inicio)),
       assert(moneda == espacio.moneda);

  final String id;
  final Espacio espacio;
  final Usuario usuario;
  final String actividad;
  final DateTime inicio;
  final DateTime fin;
  final int asistentes;
  final EstadoReserva estado;
  final List<ServicioContratado> serviciosContratados;
  final int tarifaHoraCentimos;
  final int precioTotalCentimos;
  final String moneda;

  Duration get duracion => fin.difference(inicio);

  int get totalServiciosCentimos => serviciosContratados.fold<int>(
    0,
    (total, servicio) => total + servicio.precioCentimos,
  );
}
